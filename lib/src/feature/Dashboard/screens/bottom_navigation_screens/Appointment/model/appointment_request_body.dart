

class AppointmentRequest {
  final String lawyerId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String topic;
  final String? notes; // Nullable to match Joi schema
  final String appointmentType;
  final bool isAnonymous;

  AppointmentRequest({
    required this.lawyerId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.topic,
    this.notes,
    required this.appointmentType,
    required this.isAnonymous,
  });

  Map<String, dynamic> toJson() => {
      'lawyerId': lawyerId,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'topic': topic,
      'notes': notes ?? '',
      'appointmentType': appointmentType,
      'isAnonymous': isAnonymous,
    };
}
