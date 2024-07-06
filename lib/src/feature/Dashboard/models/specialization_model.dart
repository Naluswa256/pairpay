import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/hive_types.dart';

part 'specialization_model.g.dart';

@HiveType(typeId: HiveTypes.specializationModel)
@JsonSerializable(explicitToJson: true)
class SpecializationResponse {
  @HiveField(0)
  late List<Specialization> results;

  @HiveField(1)
  late int page;

  @HiveField(2)
  late int limit;

  @HiveField(3)
  late int totalPages;

  @HiveField(4)
  late int totalResults;

  SpecializationResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory SpecializationResponse.fromJson(Map<String, dynamic> json) => _$SpecializationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationResponseToJson(this);
}

@HiveType(typeId: HiveTypes.specialization)
@JsonSerializable(explicitToJson: true)
class Specialization extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  Specialization({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) => _$SpecializationFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationToJson(this);
}
