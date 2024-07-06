// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/core/helper/convertor.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/remote/dashboard_api_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/events/specialization_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/states/specialization_state.dart';




class SpecializationBloc extends Bloc<SpecializationEvent, SpecializationState> {
  final DashboardApiProvider apiProvider;

  SpecializationBloc({required this.apiProvider}) : super(SpecializationInitial()) {
    on<FetchSpecializations>(_mapFetchSpecializationsToState);
    on<LoadSpecializationsFromCache>(_mapLoadSpecializationsFromCacheToState);
    on<SearchSpecializations>(_mapSearchSpecializationsToState);
  }

  Future<void> _mapFetchSpecializationsToState(
  FetchSpecializations event,
  Emitter<SpecializationState> emit,
) async {
  try {
    // Fetch specializations from API
    final nextPageResult = await apiProvider.getSpecializations(page: event.page, limit: event.limit);
    final response = convertMap(nextPageResult);
    final specializationResponse = SpecializationResponse.fromJson(response);

    // Append new specializations to the existing list
    if (state is SpecializationLoadSuccess) {
      final currentState = state as SpecializationLoadSuccess;
      final updatedSpecializations = [
        ...currentState.specializations.results,
        ...specializationResponse.results,
      ];
      emit(SpecializationLoadSuccess(
        specializations: SpecializationResponse(
          results: updatedSpecializations,
          page: specializationResponse.page,
          totalPages: specializationResponse.totalPages,
          limit: specializationResponse.limit,
          totalResults: specializationResponse.totalResults,
        ),
      ));
    } else {
      emit(SpecializationLoadSuccess(
        specializations: specializationResponse,
      ));
    }
  } catch (e) {
    emit(SpecializationLoadFailure(error: _getErrorMessage(e)));
  }
}

  Future<void> _mapLoadSpecializationsFromCacheToState(
    LoadSpecializationsFromCache event,
    Emitter<SpecializationState> emit,
  ) async {
    try {
      final SpecializationResponse initialSpecializations = event.specializationResponse;
      emit(SpecializationLoadSuccess(specializations: initialSpecializations));
    } catch (e) {
      emit(SpecializationLoadFailure(error: e.toString()));
    }
  }


  Future<void> _mapSearchSpecializationsToState(
    SearchSpecializations event,
    Emitter<SpecializationState> emit,
  ) async {
    try {
      // Search specializations from API
      final searchResult = await apiProvider.searchSpecializations(event.query, page: event.page, limit: event.limit);
      final response = convertMap(searchResult);
    final specializationResponse = SpecializationResponse.fromJson(response);
      emit(SpecializationLoadSuccess(specializations: specializationResponse));
    } catch (e) {
      emit(SpecializationLoadFailure(error: e.toString()));
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
