import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  Notification({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    required this.payload,
  });

  final String title;
  final String description;
  final DateTime timestamp;
  final NotificationType type;
  final String payload;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

enum NotificationType { donation, request }
