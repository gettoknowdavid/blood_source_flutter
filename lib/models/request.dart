import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable(explicitToJson: true)
class Request {
  final String uid;
  final RequestUser user;
  final BloodGroup bloodGroup;
  final bool requestGranted;
  final DateTime? timeAdded;

  const Request({
    required this.uid,
    required this.user,
    required this.bloodGroup,
    required this.requestGranted,
    this.timeAdded,
  });

  Request.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : uid = snapshot.data()?["uid"] as String,
        user = RequestUser.fromJson(
            snapshot.data()?['user'] as Map<String, dynamic>),
        bloodGroup =
            $enumDecode($BloodGroupTypeEnum, snapshot.data()?["bloodGroup"]),
        requestGranted = snapshot.data()?["requestGranted"] as bool,
        timeAdded = (snapshot.data()?['timeAdded'] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "user": user.toFirestore(),
      "bloodGroup": $BloodGroupTypeEnum[bloodGroup],
      "requestGranted": requestGranted,
      "timeAdded": Timestamp.fromDate(DateTime.now()),
    };
  }

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
