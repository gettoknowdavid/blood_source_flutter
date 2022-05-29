import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/user_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class Request {
  final String user;
  final BloodGroup bloodGroup;
  final UserLocation requestLocation;
  final bool showContactInfo;
  final bool requestGranted;

  const Request({
    required this.user,
    required this.bloodGroup,
    required this.requestLocation,
    required this.showContactInfo,
    required this.requestGranted,
  });

  Request.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : user = snapshot.data()?['user'] as String,
        bloodGroup =
            $enumDecode($BloodGroupTypeEnum, snapshot.data()?["bloodGroup"]),
        requestLocation = UserLocation.fromJson(
            snapshot.data()?['requestLocation'] as Map<String, dynamic>),
        showContactInfo = snapshot.data()?["showContactInfo"] as bool,
        requestGranted = snapshot.data()?["requestGranted"] as bool;

  Map<String, dynamic> toFirestore() {
    return {
      "user": user,
      "requestLocation": requestLocation.toFirestore(),
      "bloodGroup": $BloodGroupTypeEnum[bloodGroup],
      "showContactInfo": showContactInfo,
      "requestGranted": requestGranted,
    };
  }

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
