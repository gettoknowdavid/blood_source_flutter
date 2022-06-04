// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      payload: json['payload'] as String,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$NotificationTypeEnumMap[instance.type],
      'payload': instance.payload,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.donation: 'donation',
  NotificationType.request: 'request',
};
