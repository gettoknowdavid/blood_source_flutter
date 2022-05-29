import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/user_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class Request {
  final String userId;
  final BloodGroup bloodGroup;
  final UserLocation requestLocation;
  final bool showContactInfo;

  const Request({
    required this.userId,
    required this.bloodGroup,
    required this.requestLocation,
    required this.showContactInfo,
  });

  Request.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : userId = snapshot.data()?['userId'] as String,
        bloodGroup =
            $enumDecode($BloodGroupTypeEnum, snapshot.data()?["bloodGroup"]),
        requestLocation = snapshot.data()?['requestLocation'] as UserLocation,
        showContactInfo = snapshot.data()?["showContactInfo"] as bool;

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "requestLocation": UserLocation(
        requestLocation.latitude,
        requestLocation.longitude,
      ),
      "bloodGroup": $BloodGroupTypeEnum[bloodGroup],
      "showContactInfo": showContactInfo,
    };
  }

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
