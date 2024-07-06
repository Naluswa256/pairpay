// ignore_for_file: strict_raw_type

import 'package:bloc/bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';

import 'package:sizzle_starter/src/feature/Dashboard/repository/dashboard_repository.dart';
import 'package:sizzle_starter/src/feature/Dashboard/resources/data_state.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/dashboard_status/dashboard_status.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/events/dashboard_event.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/states/dashboard_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;


  HomeBloc(this._homeRepository)
      : super(HomeState(
          homeDashboardStatus: DashboardStatusInit(),
        )) {
    on<HomeCallTimelineSetupEvent>(_onHomeCallAppSettingsDataEvent);
  }

  /// on call Call Featured Product Data Event
  Future<void> _onHomeCallAppSettingsDataEvent(
    HomeCallTimelineSetupEvent  event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        newhomeDashboardStatus: DashboardStatusLoading(),
      ),
    );

    final DataState dataState = await _homeRepository.fetchData();

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          newhomeDashboardStatus:
              DashboardStatusCompleted(dataState.data!),
        ),
      );
    }

    /// Failed
    if (dataState is DataFailed) {
      emit(state.copyWith(
        newhomeDashboardStatus:
            DashboardStatusError(dataState.error!),
      ));
    }
  }
}