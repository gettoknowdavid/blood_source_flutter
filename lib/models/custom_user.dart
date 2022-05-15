import 'package:blood_source/models/user-type.dart';
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
  });

  final int age;
  final int weight;
  final String bloodGroup;
  final List<String> diseases;
  final bool piercingOrTattoo;
  final bool pregnantOrBreastFeeding;
  final UserType userType;

  factory CustomUser.fromJson(Map<String, dynamic> json) =>
      _$CustomUserFromJson(json);
  Map<String, dynamic> toJson() => _$CustomUserToJson(this);
}
