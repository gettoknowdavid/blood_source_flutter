import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/models/user_location.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blood_source_user.g.dart';

@JsonSerializable(explicitToJson: true)
class BloodSourceUser {
  final String? uid;

  final String? name;

  final Gender? gender;

  /// The age of the donor which should not be
  /// below 18 or above 60.
  /// For recipients, any age is allowed.
  final num? age;

  final num? height;

  /// The weight of the donor which must be
  /// greater than 45kg
  final num? weight;

  final String? phone;

  final String? city;

  final UserLocation? location;

  final String? email;

  final String? avatar;

  /// The [BloodGroup] of the donor
  final BloodGroup? bloodGroup;

  /// A [List<Disease>] which the user may or may
  /// not have had
  final List<String>? diseases;

  /// Returns a bool of either true or
  /// false if the user has had any piercings
  /// or tattoos in the last 6 months
  final bool? piercingOrTattoo;

  /// Returns a bool of either true or
  /// false if the user is pregnant and/or breast
  /// feeding
  final bool? pregnantOrBreastFeeding;

  /// The [UserType] of the application user
  final UserType userType;

  /// Returns true if the user has met the donor
  /// requirements.
  /// Will return false otherwise.
  final bool? isDonorEligible;

  /// Returns true if the user has filled the donor
  /// requirements form.
  /// WIll return false otherwise.
  final bool isDonorFormComplete;

  const BloodSourceUser({
    required this.uid,
    this.name,
    this.gender = Gender.none,
    this.age,
    this.height,
    this.weight,
    this.phone,
    this.city,
    this.location,
    this.email,
    this.avatar,
    this.bloodGroup = BloodGroup.none,
    this.diseases,
    this.piercingOrTattoo,
    this.pregnantOrBreastFeeding,
    required this.userType,
    this.isDonorEligible,
    required this.isDonorFormComplete,
  });

  BloodSourceUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : uid = snapshot.data()?['uid'] as String?,
        name = snapshot.data()?['name'] as String?,
        gender = $enumDecode($GenderTypeEnum, snapshot.data()?["gender"]),
        age = snapshot.data()?["age"] as num?,
        height = snapshot.data()?["height"] as num?,
        weight = snapshot.data()?["weight"] as num?,
        city = snapshot.data()?['city'] as String?,
        location = snapshot.data()?['location'] == null
            ? null
            : UserLocation.fromJson(
                snapshot.data()?['location'] as Map<String, dynamic>),
        phone = snapshot.data()?['phone'] as String?,
        email = snapshot.data()?['email'] as String?,
        avatar = snapshot.data()?['avatar'] as String?,
        bloodGroup =
            $enumDecode($BloodGroupTypeEnum, snapshot.data()?["bloodGroup"]),
        diseases = (snapshot.data()?["diseases"] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        piercingOrTattoo = snapshot.data()?["piercingOrTattoo"] as bool?,
        pregnantOrBreastFeeding =
            snapshot.data()?["pregnantOrBreastFeeding"] as bool?,
        userType = $enumDecode($UserTypeEnum, snapshot.data()?['userType']),
        isDonorEligible = snapshot.data()?["isDonorEligible"] as bool?,
        isDonorFormComplete = snapshot.data()?["isDonorFormComplete"] as bool;

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      if (name != null) "name": name,
      if (gender != null) "gender": $GenderTypeEnum[gender],
      if (age != null) "age": age,
      if (height != null) "height": height,
      if (weight != null) "weight": weight,
      if (city != null) "city": city,
      if (location != null) "location": location?.toFirestore(),
      if (phone != null) "phone": phone,
      if (email != null) "email": email,
      if (avatar != null) "avatar": avatar,
      if (bloodGroup != null) "bloodGroup": $BloodGroupTypeEnum[bloodGroup],
      if (diseases != null) "diseases": diseases,
      if (piercingOrTattoo != null) "piercingOrTattoo": piercingOrTattoo,
      if (pregnantOrBreastFeeding != null)
        "pregnantOrBreastFeeding": pregnantOrBreastFeeding,
      "userType": $UserTypeEnum[userType],
      if (isDonorEligible != null) "isDonorEligible": isDonorEligible,
      "isDonorFormComplete": isDonorFormComplete,
    };
  }

  factory BloodSourceUser.fromJson(Map<String, dynamic> json) =>
      _$BloodSourceUserFromJson(json);

  Map<String, dynamic> toJson() => _$BloodSourceUserToJson(this);
}
