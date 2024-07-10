import 'package:equatable/equatable.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object?> get props => [];
}

class AppointmentsLoading extends AppointmentsState {}
class AppointmentsIntial extends AppointmentsState {}
class AppointmentsLoaded extends AppointmentsState {
  final AppointmentResponse appointmentResponse;

  const AppointmentsLoaded(this.appointmentResponse);

  @override
  List<Object?> get props => [appointmentResponse];
}

class AppointmentsError extends AppointmentsState {
  final String error;

  const AppointmentsError(this.error);

  @override
  List<Object?> get props => [error];
}
