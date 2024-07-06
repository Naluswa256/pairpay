
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/core/helper/convertor.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/remote/dashboard_api_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/events/lawyer_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/states/lawyer_state.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

class LawyerBloc extends Bloc<LawyerEvent, LawyerState> {
  final DashboardApiProvider apiProvider;

  LawyerBloc({required this.apiProvider}) : super(LawyerInitial()) {
    on<FetchLawyers>(_mapFetchLawyersToState);
    on<SearchLawyers>(_mapSearchLawyersToState);
  }

  Future<void> _mapFetchLawyersToState(
  FetchLawyers event,
  Emitter<LawyerState> emit,
) async {
  try {
    // Fetch specializations from API
    final nextPageResult = await apiProvider.fetchLawyersBySpecialization(page: event.page, limit: event.limit, specializationId: event.specializationId);
    final response = convertMap(nextPageResult);
    final userResponse = UserResponse.fromJson(response);


    // Append new specializations to the existing list
    if (state is LawyerLoadSuccess) {
      final currentState = state as LawyerLoadSuccess;
      final updatedSpecializations = [
        ...currentState.lawyers.results,
        ...userResponse.results,
      ];
      emit(LawyerLoadSuccess(
        lawyers: UserResponse(
          results: updatedSpecializations,
          page: userResponse.page,
          totalPages:userResponse.totalPages,
          limit: userResponse.limit,
          totalResults:userResponse.totalResults,
        ),
      ));
    } else {
      emit(LawyerLoadSuccess(
        lawyers: userResponse,
      ));
    }
  } catch (e) {
    emit(LawyerLoadFailure(error: _getErrorMessage(e)));
  }
}

  Future<void> _mapSearchLawyersToState(
    SearchLawyers event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      // Search specializations from API
      final searchResult = await apiProvider.searchLawyersInSpecializationByName
      (event.query,event.specializationId, page: event.page, limit: event.limit, );
      final response = convertMap(searchResult);
    final searchLawyersInResponseResult = UserResponse.fromJson(response);
      emit(LawyerLoadSuccess(lawyers:searchLawyersInResponseResult));
    } catch (e) {
      emit(LawyerLoadFailure(error: e.toString()));
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
