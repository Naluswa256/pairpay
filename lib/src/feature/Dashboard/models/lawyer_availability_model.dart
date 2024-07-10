import 'package:json_annotation/json_annotation.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

part 'lawyer_availability_model.g.dart';  
@JsonSerializable()
class LawyerAvailability {
  final List<String> availableDays;
  final Map<String, List<TimeSlot>> takenSlots;

  LawyerAvailability({
    required this.availableDays,
    required this.takenSlots,
  });

  factory LawyerAvailability.fromJson(Map<String, dynamic> json) =>
      _$LawyerAvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerAvailabilityToJson(this);
}


