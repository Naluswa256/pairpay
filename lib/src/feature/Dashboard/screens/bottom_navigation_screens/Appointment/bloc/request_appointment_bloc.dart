import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/core/helper/convertor.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/remote/dashboard_api_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/lawyer_availability_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/events/request_appointment_events.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/states/request_appointment_state.dart';

class RequestAppointmentBloc
    extends Bloc<LawyerAvailabilityEvent, LawyerAvailabilityState> {
  final DashboardApiProvider apiProvider;

  RequestAppointmentBloc({required this.apiProvider})
      : super(LawyerAvailabilityInitial()) {
    on<FetchLawyerAvailability>(_mapFetchLawyerAvailabilityToState);
    on<CreateAppointmentEvent>(_mapCreateAppointmentEventToState);
  }

  void _mapFetchLawyerAvailabilityToState(
    FetchLawyerAvailability event,
    Emitter<LawyerAvailabilityState> emit,
  ) async {
    emit(LawyerAvailabilityLoading());
    try {
      final lawyerAvailabilityResponse =
          await apiProvider.fetchLawyerAvailability(lawyerId: event.lawyerId);
      final LawyerAvailability availability =
          LawyerAvailability.fromJson(convertMap(lawyerAvailabilityResponse));
      emit(LawyerAvailabilityLoaded(availability: availability));
    } catch (e) {
      emit(LawyerAvailabilityError(message: _getErrorMessage(e)));
    }
  }

  void _mapCreateAppointmentEventToState(
    CreateAppointmentEvent event,
    Emitter<LawyerAvailabilityState> emit,
  ) async {
    emit(LawyerAvailabilityLoading());
    try {
      await apiProvider.createAppointement(appointment: event.appointment);
      emit(AppointmentCreated());
    } catch (e) {
      emit(LawyerAvailabilityError(message: _getErrorMessage(e)));
    }
  }

  String _getErrorMessage(Object e) {
    if (e is CustomBackendException) {
      return e.message;
    } else if (e is RestClientException) {
      return e.message;
    } else if (e is ConnectionException) {
      return 'No internet Connection';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
