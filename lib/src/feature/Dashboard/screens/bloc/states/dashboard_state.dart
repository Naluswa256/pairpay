
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/dashboard_status/dashboard_status.dart';

@immutable
class HomeState extends Equatable {
  final DashboardStatus homeDashboardStatus;

  const HomeState({
    required this.homeDashboardStatus,
  });

  HomeState copyWith({
    DashboardStatus? newhomeDashboardStatus,
  }) => HomeState(
      homeDashboardStatus: newhomeDashboardStatus ?? homeDashboardStatus,
    );

  @override
  List<Object?> get props => [
        homeDashboardStatus,
      ];
}