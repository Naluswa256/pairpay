import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeCallTimelineSetupEvent extends HomeEvent {
  const HomeCallTimelineSetupEvent();

  @override
  List<Object> get props => [];
}