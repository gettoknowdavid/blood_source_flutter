// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUser _$RequestUserFromJson(Map<String, dynamic> json) => RequestUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      location: UserLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestUserToJson(RequestUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'avatar': instance.avatar,
      'location': instance.location.toJson(),
    };
