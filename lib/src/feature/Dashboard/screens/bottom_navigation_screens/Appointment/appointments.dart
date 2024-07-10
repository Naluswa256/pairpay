import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/appointment_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/events/appointment_events.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/states/appointement_states.dart';
import 'package:intl/intl.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/dashboard_screen.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/data/local/user_local_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO; 

class AllAppointmentsScreen extends StatefulWidget {

  const AllAppointmentsScreen({Key? key,}) : super(key: key);

  @override
  State<AllAppointmentsScreen> createState() => _AllAppointmentsScreenState();
}

enum FilterStatus { Confirmed, Completed, Cancelled }

class _AllAppointmentsScreenState extends State<AllAppointmentsScreen> {
  FilterStatus status = FilterStatus.Confirmed;
  Alignment _alignment = Alignment.centerLeft;
  late AppointmentBloc _appointmentBloc;
  late IO.Socket socket;
  User? _user;
  final UserService _userService = UserService();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appointmentBloc = DependenciesScope.of(context).appointmentBloc;
    _appointmentBloc.add(
    LoadAppointmentsFromCache(),
    );
  }
  @override
  void initState() {
    super.initState();
    _loadUser();
    connectToSocket();
  }

  void connectToSocket() {
    const String renderUrl = 'https://lawyer-consult-api.onrender.com'; 
    final IO.Socket socket = IO.io(renderUrl, IO.OptionBuilder()
    .setTransports(['websocket'])
    .disableAutoConnect()
    .build());

  socket.onConnect((_) {
    logger.info('connected');
    socket.emit('register', {'userId': _user!.id});
  });

  socket.on('disconnect', (_) => logger.info('disconnected'));

  socket.on('new appointment', (data) {
    logger.info('New appointment: $data');
  });

  socket.connect();
  }
  
  
  Future<void> _loadUser() async {
    final User? user = await _userService.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
   List<Appointment> filteredAppointments;

    return BlocProvider(
      create: (context) => _appointmentBloc,
      child: Scaffold(
        appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffFAFAFA),
        title: Text(
          "All Appointments",
          style: const TextStyle(
              color: Color(0xff222B45),
              fontFamily: "Poppins-SemiBold",
              fontSize: 16),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.bg),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (FilterStatus filterStatus in FilterStatus.values)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (filterStatus == FilterStatus.Confirmed) {
                                    status = FilterStatus.Confirmed;
                                    _alignment = Alignment.centerLeft;
                                  } else if (filterStatus == FilterStatus.Completed) {
                                    status = FilterStatus.Completed;
                                    _alignment = Alignment.center;
                                  } else if (filterStatus == FilterStatus.Cancelled) {
                                    status = FilterStatus.Cancelled;
                                    _alignment = Alignment.centerRight;
                                  }
                                });
                              },
                              child: Center(
                                child: Text(
                                  filterStatus.name,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedAlign(
                    duration: Duration(milliseconds: 200),
                    alignment: _alignment,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(MyColors.primary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          status.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<AppointmentBloc, AppointmentsState>(
                  builder: (context, state) {
                    if (state is AppointmentsLoading) {
                     return CustomLoading.showWithStyle(context);
                    } else if (state is AppointmentsLoaded) {
                      
                      filteredAppointments =_filterAppointmentsByStatus(state.appointmentResponse.results);
                      return ListView.builder(
                        itemCount: filteredAppointments.length,
                        itemBuilder: (context, index) {
                          var _appointment = filteredAppointments[index];
                          bool isLastElement = filteredAppointments.length - 1 == index;
                          bool showCancelButton = _appointment.status == 'confirmed';
                          return Card(
                            margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(_appointment.lawyerId.avatar),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _appointment.lawyerId.fullNames,
                                            style: TextStyle(
                                              color: Color(MyColors.header01),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Text(
                                          //   _appointment.,
                                          //   style: TextStyle(
                                          //     color: Color(MyColors.grey02),
                                          //     fontSize: 14,
                                          //     fontWeight: FontWeight.w600,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DateTimeCard(date: _appointment.date, startTime: _appointment.startTime, endTime: _appointment.endTime),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    _appointment.topic,
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (showCancelButton)
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color:Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
                                          ),
                                          onPressed: () {},
                                          child: Text('Reschedule', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is AppointmentsError) {
                      return Center(child: Text(state.error));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Appointment> _filterAppointmentsByStatus(List<Appointment> appointments) {
    switch (status) {
      case FilterStatus.Confirmed:
        return appointments.where((appointment) => appointment.status == 'confirmed').toList();
      case FilterStatus.Completed:
        return appointments.where((appointment) => appointment.status == 'completed').toList();
      case FilterStatus.Cancelled:
        return appointments.where((appointment) => appointment.status == 'cancelled').toList();
      default:
        return [];
    }
  }
}


class DateTimeCard extends StatelessWidget {
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

  const DateTimeCard({
    Key? key,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                _formattedDate(),
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                _formattedTime(),
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formattedDate() {
    String dayOfWeek = DateFormat.EEEE().format(date); // Monday
    String dayOfMonth = DateFormat.d().format(date); // 12
    String month = DateFormat.MMMM().format(date); // July

    // Add suffix to day of month
    String suffix = _getDaySuffix(int.parse(dayOfMonth));

    return '$dayOfWeek, $dayOfMonth$suffix $month';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String _formattedTime() {
    String startTimeFormatted = DateFormat.jm().format(startTime); // 10:00 AM
    String endTimeFormatted = DateFormat.jm().format(endTime); // 11:00 PM

    return '$startTimeFormatted - $endTimeFormatted';
  }
}

class MyColors {
  static int header01 = 0xff151a56;
  static int primary = 0xff575de3;
  static int purple01 = 0xff918fa5;
  static int purple02 = 0xff6b6e97;
  static int yellow01 = 0xffeaa63b;
  static int yellow02 = 0xfff29b2b;
  static int bg = 0xfff5f3fe;
  static int bg01 = 0xff6f75e1;
  static int bg02 = 0xffc3c5f8;
  static int bg03 = 0xffe8eafe;
  static int text01 = 0xffbec2fc;
  static int grey01 = 0xffe9ebf0;
  static int grey02 = 0xff9796af;
}
