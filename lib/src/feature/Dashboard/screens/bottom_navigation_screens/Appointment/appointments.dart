// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/components/date_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppointementsPage extends StatefulWidget {
  const AppointementsPage({super.key});

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

  final List<Map<String, dynamic>> timeSlots = [
    {'start': '10:00 AM', 'end': '11:00 AM', 'selected': false},
    {'start': '12:00 PM', 'end': '1:00 PM', 'selected': true},
    {'start': '2:00 PM', 'end': '3:00 PM', 'selected': false},
    {'start': '4:00 PM', 'end': '5:00 PM', 'selected': false},
  ];

  final List<String> durations = ['30 minutes', '60 minutes', '90 minutes'];
  final List<String> callTypes = [
    'Video call',
    'Phone call',
    'Physical meeting'
  ];

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
    );
    if (pickedTime != null) {
      setState(() {
        selectedStartTime = pickedTime;
        _calculateEndTime();
      });
    }
  }

  void _calculateEndTime() {
    if (selectedStartTime != null) {
      int durationMinutes = int.parse(selectedDuration.split(' ')[0]);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                padding: const EdgeInsets.only(top: 38, left: 18, right: 18),
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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Taken Slots",
                    style: TextStyle(
                        color: Color.fromARGB(255, 45, 42, 42),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  ChipGrid(timeSlots: timeSlots),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Select the Start Time",
                    style: TextStyle(
                        color: Color.fromARGB(255, 45, 42, 42),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                      labelText: 'What the consultation is about (optional)',
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
                  // Handle appointment request submission
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
    );
  }
}

class ChipGrid extends StatelessWidget {
  final List<Map<String, dynamic>> timeSlots;

  const ChipGrid({Key? key, required this.timeSlots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 3, // Adjust this ratio as needed
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final slot = timeSlots[index];
        final isSelected = slot['selected'] ?? false;

        return Chip(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide.none,
          ),
          label: Text(
            "${slot['start']} - ${slot['end']}",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(MyColors.primary),
        );
      },
    );
  }
}
