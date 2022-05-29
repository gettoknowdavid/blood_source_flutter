// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      userId: json['userId'] as String,
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      requestLocation: UserLocation.fromJson(
          json['requestLocation'] as Map<String, dynamic>),
      showContactInfo: json['showContactInfo'] as bool,
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'userId': instance.userId,
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
      'requestLocation': instance.requestLocation.toJson(),
      'showContactInfo': instance.showContactInfo,
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
