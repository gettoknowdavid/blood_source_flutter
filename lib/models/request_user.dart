import 'package:blood_source/models/user_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_user.g.dart';

@JsonSerializable(explicitToJson: true)
class RequestUser {
  final String uid;
  final String name;
  final String avatar;
  final UserLocation location;

  const RequestUser({
    required this.uid,
    required this.name,
    required this.avatar,
    required this.location,
  });

  RequestUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : uid = snapshot.data()?['uid'] as String,
        name = snapshot.data()?['name'] as String,
        avatar = snapshot.data()?['avatar'] as String,
        location = UserLocation.fromJson(
            snapshot.data()?['requestLocation'] as Map<String, dynamic>);

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "name": name,
      "avatar": avatar,
      "location": location.toFirestore(),
    };
  }

  factory RequestUser.fromJson(Map<String, dynamic> json) =>
      _$RequestUserFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUserToJson(this);
}
