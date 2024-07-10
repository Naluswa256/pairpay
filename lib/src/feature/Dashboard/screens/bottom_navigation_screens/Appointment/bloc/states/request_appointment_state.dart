
import 'package:equatable/equatable.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/lawyer_availability_model.dart';

abstract class LawyerAvailabilityState extends Equatable {
  const LawyerAvailabilityState();

  @override
  List<Object> get props => [];
}

class LawyerAvailabilityInitial extends LawyerAvailabilityState {}

class LawyerAvailabilityLoading extends LawyerAvailabilityState {}

class LawyerAvailabilityLoaded extends LawyerAvailabilityState {
  final LawyerAvailability availability;

  const LawyerAvailabilityLoaded({required this.availability});

  @override
  List<Object> get props => [availability];
}

class LawyerAvailabilityError extends LawyerAvailabilityState {
  final String message;

  const LawyerAvailabilityError({required this.message});

  @override
  List<Object> get props => [message];
}

class AppointmentLoading extends LawyerAvailabilityState {}

class AppointmentCreated extends LawyerAvailabilityState {}

class AppointmentError extends LawyerAvailabilityState {
  final String message;

  const AppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}
