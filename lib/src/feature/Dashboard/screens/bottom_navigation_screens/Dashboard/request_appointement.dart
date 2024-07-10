// ignore_for_file: public_member_api_docs, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:go_router/go_router.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/lawyer_availability_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/events/request_appointment_events.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/request_appointment_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/states/request_appointment_state.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/model/appointment_request_body.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/components/date_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';

class AppointementsPage extends StatefulWidget {
  final String lawyerId;
  const AppointementsPage({super.key, required this.lawyerId});

  @override
  State<AppointementsPage> createState() => _AppointementsPageState();
}

class _AppointementsPageState extends State<AppointementsPage> {
  int selectedIndex = 0;
  bool isAnonymous = false;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String selectedDuration = '30 minutes';
  String? selectedCallType;
  String? consultationTopic;
  String? consultationDetails;
  late RequestAppointmentBloc _requestAppointmentBloc;

  final List<String> durations = ['30 minutes', '60 minutes', '90 minutes'];
  final List<String> callTypes = ['videoCall', 'voiceCall', 'physicalMeeting'];

  onClick(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> pickStartTime(BuildContext context) async {
  final initialTime = TimeOfDay.now();

  final pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.dial,
  );

  if (pickedTime != null) {
    setState(() {
      // Validate minute value
      if (pickedTime.minute >= 0 && pickedTime.minute < 60) {
        selectedStartTime = pickedTime;
        _calculateEndTime();

        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (selectedDateTime.isBefore(now)) {
          _showErrorDialog(context, 'Cannot select a time that has already passed.');
          selectedStartTime = null;
          selectedEndTime = null;
        }
      } else {
        // Show error message for invalid minute
        _showErrorDialog(context, 'Please enter a valid minute between 0 and 59.');
      }
    });
  }
}


  void _calculateEndTime() {
    if (selectedStartTime != null) {
      final int durationMinutes = int.parse(selectedDuration.split(' ')[0]);
      final endTime = selectedStartTime!.replacing(
        hour: selectedStartTime!.hour + durationMinutes ~/ 60,
        minute: selectedStartTime!.minute + durationMinutes % 60,
      );
      setState(() {
        selectedEndTime = endTime;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestAppointmentBloc =
        DependenciesScope.of(context).requestAppointmentBloc;
    _requestAppointmentBloc
        .add(FetchLawyerAvailability(lawyerId: widget.lawyerId));
  }

  AppointmentRequest _createAppointmentRequest() {
    if (selectedStartTime == null || selectedEndTime == null) {
      throw Exception('Please select start and end times');
    }

    // Assuming you have a selected date for the appointment
    final DateTime selectedDate =
        DateTime.now(); // Replace with your actual selected date

    final DateTime startDateTime =
        _convertTimeOfDayToDateTime(selectedStartTime!, selectedDate);
    final DateTime endDateTime =
        _convertTimeOfDayToDateTime(selectedEndTime!, selectedDate);

    return AppointmentRequest(
      lawyerId: widget.lawyerId,
      date: selectedDate,
      startTime: startDateTime,
      endTime: endDateTime,
      appointmentType: selectedCallType!,
      topic: consultationTopic!,
      notes: consultationDetails,
      isAnonymous: isAnonymous,
    );
  }

  DateTime _convertTimeOfDayToDateTime(TimeOfDay timeOfDay, DateTime date) =>
      DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (BuildContext context) => _requestAppointmentBloc,
        child: Scaffold(
          body: BlocListener<RequestAppointmentBloc, LawyerAvailabilityState>(
            listener: (context, state) {
              if (state is AppointmentCreated) {
                _showAppointmentCreatedDialog(context);
              } else if (state is LawyerAvailabilityError) {
                _showErrorDialog(context, state.message);
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: const Radius.circular(30)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 38, left: 18, right: 18),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                  color: const Color(0xff222B45),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Book Your Appointment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                            ],
                          ),
                          const CustomDatePicker(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Taken Slots",
                          style: TextStyle(
                            color: Color.fromARGB(255, 45, 42, 42),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        BlocBuilder<RequestAppointmentBloc,
                            LawyerAvailabilityState>(
                          builder: (context, state) {
                            if (state is LawyerAvailabilityLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildAvailabilityWidgets(
                                    state.availability),
                              );
                            } else if (state is LawyerAvailabilityLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is LawyerAvailabilityError) {
                              return Center(
                                child: Text(
                                    'Failed to load availability: ${state.message}'),
                              );
                            } else {
                              return Container(); // Handle other states if needed
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Select the Start Time",
                          style: TextStyle(
                            color: Color.fromARGB(255, 45, 42, 42),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 200, // Specify the width
                          height: 50, // Specify the height
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(
                                0), // No border radius for sharp corners
                          ),
                          child: InkWell(
                            onTap: () => pickStartTime(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                    width:
                                        10), // Add some space between the icon and text
                                Text(
                                  selectedStartTime != null
                                      ? selectedStartTime!.format(context)
                                      : 'Select start time',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          selectedEndTime != null
                              ? 'End Time: ${selectedEndTime!.format(context)}'
                              : 'End Time: -',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          hint: const Text(
                            'Select Duration',
                            style: TextStyle(fontSize: 14),
                          ),
                          value: selectedDuration,
                          items: durations
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDuration = value!;
                              _calculateEndTime();
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              elevation: 4),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          hint: const Text(
                            'Select Call Type',
                            style: TextStyle(fontSize: 14),
                          ),
                          value: selectedCallType,
                          items: callTypes
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCallType = value!;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              elevation: 4),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Topic of Consultation',
                            hintText: 'Enter topic of consultation',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          maxLength: 50, // Ensure the topic is short
                          onChanged: (value) {
                            setState(() {
                              consultationTopic = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText:
                                'What the consultation is about (optional)',
                            hintText: 'Enter details about the consultation',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          maxLines: 3, // Maximum of 3 lines
                          maxLength: 150, // Ensure it's not too long
                          onChanged: (value) {
                            setState(() {
                              consultationDetails = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        CheckboxListTile(
                          title: const Text('Stay anonymous'),
                          subtitle: const Text(
                              'Your personal user information won\'t be shared with the lawyer.'),
                          value: isAnonymous,
                          onChanged: (bool? value) {
                            setState(() {
                              isAnonymous = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                      ),
                      onPressed: () {
                        _validateAndSubmitAppointmentRequest();
                      },
                      child: const Text(
                        "Send Appointment Request",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  void _validateAndSubmitAppointmentRequest() {
    if (consultationTopic == null || consultationTopic!.isEmpty) {
      _showErrorDialog(context, 'Please enter the topic of consultation.');
      return;
    }
    if (selectedCallType == null || selectedCallType!.isEmpty) {
      _showErrorDialog(context, 'Please select the call type.');
      return;
    }
    if (selectedDuration.isEmpty) {
      _showErrorDialog(context, 'Please select the duration.');
      return;
    }
    if (consultationDetails == null || consultationDetails!.isEmpty) {
      _showErrorDialog(context, 'Please enter details about the consultation.');
      return;
    }
    // Proceed with appointment request submission
    try {
      final AppointmentRequest appointmentRequest = _createAppointmentRequest();
      _requestAppointmentBloc
          .add(CreateAppointmentEvent(appointment: appointmentRequest));
    } catch (e) {
      _showErrorDialog(context, 'Failed to create appointment: $e');
    }
  }

  List<Widget> _buildAvailabilityWidgets(LawyerAvailability availability) {
    final List<Widget> widgets = [];

    if (availability.takenSlots.isEmpty) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.calendar_today_sharp,
                size: 50,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Lawyer has no taken slots yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    } else {
      // Loop through the takenSlots map
      availability.takenSlots.forEach((date, timeSlots) {
        widgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: $date', // Display date
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var slot in timeSlots)
                    _buildTimeSlotChip(slot), // Display each time slot
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      });
    }

    return widgets;
  }

  Widget _buildTimeSlotChip(TimeSlot slot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${slot.startTime} - ${slot.endTime}', // Display start and end time
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        // Optionally add more details or actions related to the time slot
      ],
    );
  }

  // Method to show appointment created dialog
  void _showAppointmentCreatedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Appointment Created Successfully'),
        content: Text('Your appointment request has been successfully sent.'),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/home');
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
