// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      user: RequestUser.fromJson(json['user'] as Map<String, dynamic>),
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      showContactInfo: json['showContactInfo'] as bool,
      requestGranted: json['requestGranted'] as bool,
      timeAdded: json['timeAdded'] == null
          ? null
          : DateTime.parse(json['timeAdded'] as String),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
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
