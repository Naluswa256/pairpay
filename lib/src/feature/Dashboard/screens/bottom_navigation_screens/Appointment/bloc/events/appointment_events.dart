import 'package:equatable/equatable.dart';


abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppointmentsFromCache extends AppointmentsEvent {}

class RefreshAppointments extends AppointmentsEvent {}
