import 'package:equatable/equatable.dart';

abstract class LawyerEvent extends Equatable {
  const LawyerEvent();

  @override
  List<Object> get props => [];
}

class FetchLawyers extends LawyerEvent {
  final int page;
  final int limit;
  final String specializationId;

  FetchLawyers({required this.page, required this.limit, required this.specializationId});

  @override
  List<Object> get props => [page, limit, specializationId];
}

class SearchLawyers extends LawyerEvent {
  final String query;
  final int page;
  final int limit;
  final String? specializationId;
  SearchLawyers({required this.query, required this.page, required this.limit, this.specializationId});

  @override
  List<Object> get props => [query, page, limit];
}
