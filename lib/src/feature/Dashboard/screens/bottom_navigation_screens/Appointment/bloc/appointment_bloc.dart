// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/dashboard_database_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/remote/dashboard_api_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/events/appointment_events.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/bloc/states/appointement_states.dart';




class AppointmentBloc extends Bloc<AppointmentsEvent,AppointmentsState> {
  final DashboardApiProvider apiProvider;
  final HomeDataBaseProvider dbProvider;

  AppointmentBloc({required this.apiProvider, required this.dbProvider}) : super(AppointmentsIntial()) {
    on<LoadAppointmentsFromCache>(_mapLoadAppointmentsFromCacheToState);
  }


  Future<void> _mapLoadAppointmentsFromCacheToState(
    LoadAppointmentsFromCache event,
    Emitter<AppointmentsState> emit,
  ) async {
    try {
      final initialAppointments = await dbProvider.getAppointmentsByUser();
      emit(AppointmentsLoaded(initialAppointments!));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  String _getErrorMessage(Object e) {
    if (e is CustomBackendException) {
      return e.message;
    } else if (e is RestClientException) {
      return e.message;
    }else if (e is ConnectionException) {
      return 'No internet Connection';
    }
     else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
