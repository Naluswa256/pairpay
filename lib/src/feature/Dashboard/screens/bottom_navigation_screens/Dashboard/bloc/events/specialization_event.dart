

import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';

abstract class SpecializationEvent {}

class FetchSpecializations extends SpecializationEvent {
  final int page;
  final int limit;

  FetchSpecializations({required this.page, required this.limit});
}
class SearchSpecializations extends SpecializationEvent{
  final String query;
  final int page;
  final int limit;

  SearchSpecializations({
    required this.query,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [query, page, limit];
}


class LoadSpecializationsFromCache extends SpecializationEvent {
  final SpecializationResponse specializationResponse;

  LoadSpecializationsFromCache({required this.specializationResponse});
}
