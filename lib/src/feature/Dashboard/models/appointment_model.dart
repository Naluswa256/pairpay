import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 14)
@JsonSerializable(explicitToJson: true)
class AppointmentResponse {
  @HiveField(0)
  late List<Appointment> results;

  @HiveField(1)
  late int page;

  @HiveField(2)
  late int limit;

  @HiveField(3)
  late int totalPages;

  @HiveField(4)
  late int totalResults;

  AppointmentResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) => _$AppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentResponseToJson(this);
}

@HiveType(typeId: 18)
@JsonSerializable(explicitToJson: true)
class Appointment {
  @HiveField(0)
  final Package package;

  @HiveField(1)
  final String status;

  @HiveField(2)
  final String paymentStatus;

  @HiveField(3)
  final String bookingReference;

  @HiveField(4)
  final bool isAnonymous;

  @HiveField(5)
  final Attendee userId;

  @HiveField(6)
  final String appointmentType;

  @HiveField(7)
  final Attendee lawyerId;

  @HiveField(8)
  final DateTime date;

  @HiveField(9)
  final DateTime startTime;

  @HiveField(10)
  final DateTime endTime;

  @HiveField(11)
  final String topic;

  @HiveField(12)
  final String id;

  @HiveField(13)
  final String notes;
  @HiveField(14)
  final String transactionReference;

  Appointment({
    required this.package,
    required this.status,
    required this.paymentStatus,
    required this.bookingReference,
    required this.isAnonymous,
    required this.userId,
    required this.appointmentType,
    required this.lawyerId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.topic,
    required this.id,
    required this.notes,
    required this.transactionReference
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

@HiveType(typeId: 12)
@JsonSerializable(explicitToJson: true)
class Package extends HiveObject {
  @HiveField(0)
  final int duration;

  @HiveField(1)
  final int price;

  Package({
    required this.duration,
    required this.price,
  });

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

@HiveType(typeId: 13)
@JsonSerializable(explicitToJson: true)
class Attendee extends HiveObject {
  @HiveField(0)
  final String fullNames;

  @HiveField(1)
  final String avatar;

  @HiveField(2)
  final String id;

  Attendee({
    required this.fullNames,
    required this.avatar,
    required this.id,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) => _$AttendeeFromJson(json);

  Map<String, dynamic> toJson() => _$AttendeeToJson(this);
}
