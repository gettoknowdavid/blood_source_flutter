// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      uid: json['uid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      timeAdded: DateTime.parse(json['timeAdded'] as String),
      creator: EventCreator.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'timeAdded': instance.timeAdded.toIso8601String(),
      'creator': instance.creator.toJson(),
    };
