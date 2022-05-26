import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_location.g.dart';

@JsonSerializable(explicitToJson: true)
class UserLocation {
  /// Create [Location] instance.
  const UserLocation(this.latitude, this.longitude)
      : assert(latitude >= -90 && latitude <= 90),
        assert(longitude >= -180 && longitude <= 180);

  final double latitude; // ignore: public_member_api_docs
  final double longitude; // ignore: public_member_api_docs

  @override
  bool operator ==(Object other) =>
      other is UserLocation &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => hashValues(latitude, longitude);

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}
