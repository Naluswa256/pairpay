

import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';

abstract class SpecializationState {}

class SpecializationInitial extends SpecializationState {}

class SpecializationLoadSuccess extends SpecializationState {
  final SpecializationResponse specializations;

  SpecializationLoadSuccess({required this.specializations});
}

class SpecializationLoadFailure extends SpecializationState {
  final String error;

  SpecializationLoadFailure({required this.error});
}
