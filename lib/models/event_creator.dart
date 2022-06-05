import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_creator.g.dart';

@JsonSerializable(explicitToJson: true)
class EventCreator {
  EventCreator({required this.uid, required this.name, required this.avatar});

  final String uid;
  final String name;
  final String avatar;

  EventCreator.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : uid = snapshot.data()?['uid'] as String,
        name = snapshot.data()?['name'] as String,
        avatar = snapshot.data()?['avatar'] as String;

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "name": name,
      "avatar": avatar,
    };
  }

  factory EventCreator.fromJson(Map<String, dynamic> json) =>
      _$EventCreatorFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreatorToJson(this);
}
