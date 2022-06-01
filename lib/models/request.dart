import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class Request {
  final RequestUser user;
  final BloodGroup bloodGroup;
  final bool showContactInfo;
  final bool requestGranted;
  final DateTime? timeAdded;

  const Request({
    required this.user,
    required this.bloodGroup,
    required this.showContactInfo,
    required this.requestGranted,
    this.timeAdded,
  });

  Request.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : user = RequestUser.fromJson(
            snapshot.data()?['user'] as Map<String, dynamic>),
        bloodGroup =
            $enumDecode($BloodGroupTypeEnum, snapshot.data()?["bloodGroup"]),
        showContactInfo = snapshot.data()?["showContactInfo"] as bool,
        requestGranted = snapshot.data()?["requestGranted"] as bool,
        timeAdded = (snapshot.data()?['timeAdded'] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() {
    return {
      "user": user.toFirestore(),
      "bloodGroup": $BloodGroupTypeEnum[bloodGroup],
      "showContactInfo": showContactInfo,
      "requestGranted": requestGranted,
      "timeAdded": Timestamp.fromDate(DateTime.now()),
    };
  }

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
