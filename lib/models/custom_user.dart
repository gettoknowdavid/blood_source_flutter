import 'package:blood_source/models/user-type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_user.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomUser {
  CustomUser({
    required this.age,
    required this.weight,
    required this.bloodGroup,
    required this.diseases,
    required this.piercingOrTattoo,
    required this.pregnantOrBreastFeeding,
    required this.userType,
    required this.isDonorEligible,
    required this.isDonorFormComplete,
  });

  /// The age of the donor which should not be
  /// below 18 or above 60.
  /// For recipients, any age is allowed.
  final int age;

  /// The weight of the donor which must be
  /// greater than 45kg
  final int weight;

  /// The [BloodGroup] of the donor
  final String bloodGroup;

  /// A [List<Disease>] which the user may or may
  /// not have had
  final List<String> diseases;

  /// Returns a bool of either true or
  /// false if the user has had any piercings
  /// or tattoos in the last 6 months
  final bool piercingOrTattoo;

  /// Returns a bool of either true or
  /// false if the user is pregnant and/or breast
  /// feeding
  final bool pregnantOrBreastFeeding;

  /// The [UserType] of the application user
  final UserType userType;

  /// Returns true if the user has met the donor
  /// requirements.
  /// Will return false otherwise.
  final bool isDonorEligible;

  /// Returns true if the user has filled the donor
  /// requirements form.
  /// WIll return false otherwise.
  final bool isDonorFormComplete;

  factory CustomUser.fromJson(Map<String, dynamic> json) =>
      _$CustomUserFromJson(json);
  Map<String, dynamic> toJson() => _$CustomUserToJson(this);

  CustomUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : age = snapshot.data()?["age"],
        weight = snapshot.data()?["weight"],
        bloodGroup = snapshot.data()?["bloodGroup"],
        diseases = (snapshot.data()?["diseases"] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        piercingOrTattoo = snapshot.data()?["piercingOrTattoo"],
        pregnantOrBreastFeeding = snapshot.data()?["pregnantOrBreastFeeding"],
        userType = snapshot.data()?["userType"],
        isDonorEligible = snapshot.data()?["isDonorEligible"],
        isDonorFormComplete = snapshot.data()?["isDonorFormComplete"];

  Map<String, dynamic> toFirestore() {
    return {
      if (age != null) "age": age,
      if (weight != null) "weight": weight,
      if (bloodGroup != null) "bloodGroup": bloodGroup,
      if (diseases != null) "diseases": diseases,
      if (piercingOrTattoo != null) "piercingOrTattoo": piercingOrTattoo,
      if (pregnantOrBreastFeeding != null)
        "pregnantOrBreastFeeding": pregnantOrBreastFeeding,
      if (userType != null) "isDonorEligible": userType,
      if (isDonorEligible != null) "isDonorEligible": isDonorEligible,
      if (isDonorFormComplete != null)
        "isDonorFormComplete": isDonorFormComplete,
    };
  }
}
