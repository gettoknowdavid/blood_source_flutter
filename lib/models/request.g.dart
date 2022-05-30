// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      user: json['user'] as String,
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      requestLocation: UserLocation.fromJson(
          json['requestLocation'] as Map<String, dynamic>),
      showContactInfo: json['showContactInfo'] as bool,
      requestGranted: json['requestGranted'] as bool,
      timeAdded: json['timeAdded'] == null
          ? null
          : DateTime.parse(json['timeAdded'] as String),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'user': instance.user,
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
      'requestLocation': instance.requestLocation.toJson(),
      'showContactInfo': instance.showContactInfo,
      'requestGranted': instance.requestGranted,
      'timeAdded': instance.timeAdded?.toIso8601String(),
    };

const _$BloodGroupEnumMap = {
  BloodGroup.none: 'none',
  BloodGroup.aPositive: 'aPositive',
  BloodGroup.aNegative: 'aNegative',
  BloodGroup.bPositive: 'bPositive',
  BloodGroup.bNegative: 'bNegative',
  BloodGroup.oPositive: 'oPositive',
  BloodGroup.oNegative: 'oNegative',
  BloodGroup.abPositive: 'abPositive',
  BloodGroup.abNegative: 'abNegative',
};
