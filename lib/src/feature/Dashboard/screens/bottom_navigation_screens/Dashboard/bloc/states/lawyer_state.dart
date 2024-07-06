import 'package:equatable/equatable.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

abstract class LawyerState extends Equatable {
  const LawyerState();

  @override
  List<Object> get props => [];
}

class LawyerInitial extends LawyerState {}

class LawyerLoadSuccess extends LawyerState {
  final UserResponse lawyers;

  LawyerLoadSuccess({required this.lawyers});

  @override
  List<Object> get props => [lawyers];
}

class LawyerLoadFailure extends LawyerState {
  final String error;

  LawyerLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
