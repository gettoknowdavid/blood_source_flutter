// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_source_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodSourceUser _$BloodSourceUserFromJson(Map<String, dynamic> json) =>
    BloodSourceUser(
      uid: json['uid'] as String?,
      initEdit: json['initEdit'] as int?,
      name: json['name'] as String?,
      gender:
          $enumDecodeNullable(_$GenderEnumMap, json['gender']) ?? Gender.none,
      age: json['age'] as num?,
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      location: json['location'] == null
          ? null
          : UserLocation.fromJson(json['location'] as Map<String, dynamic>),
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      bloodGroup:
          $enumDecodeNullable(_$BloodGroupEnumMap, json['bloodGroup']) ??
              BloodGroup.none,
      diseases: (json['diseases'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      piercingOrTattoo: json['piercingOrTattoo'] as bool?,
      pregnantOrBreastFeeding: json['pregnantOrBreastFeeding'] as bool?,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      isDonorEligible: json['isDonorEligible'] as bool?,
      isDonorFormComplete: json['isDonorFormComplete'] as bool,
    );

Map<String, dynamic> _$BloodSourceUserToJson(BloodSourceUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'initEdit': instance.initEdit,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'phone': instance.phone,
      'city': instance.city,
      'location': instance.location?.toJson(),
      'email': instance.email,
      'avatar': instance.avatar,
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
      'diseases': instance.diseases,
      'piercingOrTattoo': instance.piercingOrTattoo,
      'pregnantOrBreastFeeding': instance.pregnantOrBreastFeeding,
      'userType': _$UserTypeEnumMap[instance.userType],
      'isDonorEligible': instance.isDonorEligible,
      'isDonorFormComplete': instance.isDonorFormComplete,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.none: 'none',
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

const _$UserTypeEnumMap = {
  UserType.donor: 'donor',
  UserType.recipient: 'recipient',
};
