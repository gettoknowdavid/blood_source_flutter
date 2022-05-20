// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomUser _$CustomUserFromJson(Map<String, dynamic> json) => CustomUser(
      age: json['age'] as int?,
      weight: json['weight'] as int?,
      bloodGroup: json['bloodGroup'] as String?,
      diseases: (json['diseases'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      piercingOrTattoo: json['piercingOrTattoo'] as bool?,
      pregnantOrBreastFeeding: json['pregnantOrBreastFeeding'] as bool?,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      isDonorEligible: json['isDonorEligible'] as bool?,
      isDonorFormComplete: json['isDonorFormComplete'] as bool,
    );

Map<String, dynamic> _$CustomUserToJson(CustomUser instance) =>
    <String, dynamic>{
      'age': instance.age,
      'weight': instance.weight,
      'bloodGroup': instance.bloodGroup,
      'diseases': instance.diseases,
      'piercingOrTattoo': instance.piercingOrTattoo,
      'pregnantOrBreastFeeding': instance.pregnantOrBreastFeeding,
      'userType': _$UserTypeEnumMap[instance.userType],
      'isDonorEligible': instance.isDonorEligible,
      'isDonorFormComplete': instance.isDonorFormComplete,
    };

const _$UserTypeEnumMap = {
  UserType.donor: 'donor',
  UserType.recipient: 'recipient',
};
