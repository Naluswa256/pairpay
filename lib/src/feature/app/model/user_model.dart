// ignore_for_file: lines_longer_than_80_chars

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sizzle_starter/src/core/helper/convertor.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 10)
@JsonSerializable(explicitToJson: true)
class UserResponse {
  @HiveField(0)
  late List<User> results;

  @HiveField(1)
  late int page;

  @HiveField(2)
  late int limit;

  @HiveField(3)
  late int totalPages;

  @HiveField(4)
  late int totalResults;

  UserResponse({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}


@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class User{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fullNames;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String about;

  @HiveField(5)
  final String avatar;

  @HiveField(6)
  final String role;

  @HiveField(7)
  final bool isEmailVerified;

  @HiveField(8)
  final bool isPhoneNumberVerified;

  @HiveField(9)
  final bool isProfilePublic;

  @HiveField(10)
  final bool isVerified;

  @HiveField(11)
  final List<Appointment> appointments;

  @HiveField(12)
  final bool availableForWork;

  @HiveField(13)
  final int yearsOfExperience;

  @HiveField(14)
  final List<SpecializationPopulated> specializations;

  @HiveField(16)
  final double averageRating;

  @HiveField(17)
  final int numOfReviews;

  @HiveField(18)
  final String email;

  @HiveField(19)
  final List<AvailableSlot> availableSlots;

  @HiveField(20)
  final List<EmploymentHistory> employmentHistory;

  @HiveField(21)
  final List<Education> education;

  @HiveField(22)
  final List<SocialMediaLinkedAccount> socialMediaLinkedAccounts;

  @HiveField(23)
  final List<Review> reviewsReceived;
   @HiveField(24)
  final List<Review> reviewsGiven;
  @HiveField(25)
  final int completedConsultations;

  User({
    required this.id,
    required this.about,
    required this.fullNames,
    required this.phoneNumber,
    required this.location,
    required this.avatar,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneNumberVerified,
    required this.isProfilePublic,
    required this.isVerified,
    required this.appointments,
    required this.availableForWork,
    required this.yearsOfExperience,
    required this.specializations,
    required this.averageRating,
    required this.numOfReviews,
    required this.email,
    required this.availableSlots,
    required this.employmentHistory,
    required this.education,
    required this.socialMediaLinkedAccounts,
    required this.reviewsReceived,
    required this.reviewsGiven,
    required this.completedConsultations,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable()
class AvailableSlot {
  @HiveField(0)
  @JsonKey(name: '_id')
  final String id;

  @HiveField(1)
  final String day;

  @HiveField(2)
  final List<TimeSlot> timeSlots;

  AvailableSlot({
    required this.id,
    required this.day,
    required this.timeSlots,
  });

  factory AvailableSlot.fromJson(Map<String, dynamic> json) => _$AvailableSlotFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableSlotToJson(this);
}

@HiveType(typeId: 20)
@JsonSerializable()
class TimeSlot {
  @HiveField(0)
  @JsonKey(name: '_id')
  final String id;

  @HiveField(1)
  final String startTime;

  @HiveField(2)
  final String endTime;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}


@HiveType(typeId: 2)
@JsonSerializable()
class EmploymentHistory {
  @HiveField(0)
  @JsonKey(name: '_id')
  final String id;

  @HiveField(1)
  final String companyName;

  @HiveField(2)
  final String jobTitle;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String startMonth;

  @HiveField(5)
  final int startYear;

  @HiveField(6)
  final String endMonth;

  @HiveField(7)
  final int? endYear;

  @HiveField(8)
  final bool isCurrent;

  EmploymentHistory({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.description,
    required this.startMonth,
    required this.startYear,
    required this.endMonth,
    required this.endYear,
    required this.isCurrent,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) => _$EmploymentHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$EmploymentHistoryToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class Education {
  @HiveField(0)
  @JsonKey(name: '_id')
  final String id;

  @HiveField(1)
  final String institutionName;

  @HiveField(2)
  final String degree;

  @HiveField(3)
  final String fieldOfStudy;

  @HiveField(4)
  final int startYear;

  @HiveField(5)
  final int endYear;

  @HiveField(6)
  final bool currentlyAttending;

  Education({
    required this.id,
    required this.institutionName,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    required this.currentlyAttending,
  });

  factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}


@HiveType(typeId: 4)
@JsonSerializable()
class SocialMediaLinkedAccount {
  @HiveField(0)
  @JsonKey(name: '_id')
  final String id;

  @HiveField(1)
  final String platform;

  @HiveField(2)
  final String url;

  SocialMediaLinkedAccount({
    required this.id,
    required this.platform,
    required this.url,
  });

  factory SocialMediaLinkedAccount.fromJson(Map<String, dynamic> json) => _$SocialMediaLinkedAccountFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaLinkedAccountToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class Review {
  @HiveField(0)
  final double rating;

  @HiveField(1)
  final String comment;

  @HiveField(2)
  final ReviewUser user;

  @HiveField(3)
  final ReviewUser lawyer;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  Review({
    required this.rating,
    required this.comment,
    required this.user,
    required this.lawyer, 
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@HiveType(typeId: 6)
@JsonSerializable()
class ReviewUser {
  @HiveField(0)
  final String avatar;

  @HiveField(1)
  final String fullNames;

  ReviewUser({
    required this.avatar,
    required this.fullNames,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) => _$ReviewUserFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewUserToJson(this);
}

@HiveType(typeId: 7)
@JsonSerializable()
class SpecializationPopulated {
  @HiveField(0)
  final String name;

  SpecializationPopulated({
    required this.name,
  });

  factory SpecializationPopulated.fromJson(Map<String, dynamic> json) => _$SpecializationPopulatedFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationPopulatedToJson(this);
}
