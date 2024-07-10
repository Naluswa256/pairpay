
import 'package:equatable/equatable.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/model/appointment_request_body.dart';

abstract class LawyerAvailabilityEvent extends Equatable {
  const LawyerAvailabilityEvent();

  @override
  List<Object> get props => [];
}

class FetchLawyerAvailability extends LawyerAvailabilityEvent {
  final String lawyerId;

  const FetchLawyerAvailability({required this.lawyerId});

  @override
  List<Object> get props => [lawyerId];
}

class CreateAppointmentEvent extends LawyerAvailabilityEvent {
  final AppointmentRequest appointment;

  const CreateAppointmentEvent({required this.appointment});

  @override
  List<Object> get props => [appointment];
}
