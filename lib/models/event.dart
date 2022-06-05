import 'package:blood_source/models/event_creator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  Event({
    required this.uid,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.timeAdded,
    required this.creator,
  });

  final String uid;
  final String title;
  final String description;
  final String location;
  final DateTime dateTime;
  final DateTime timeAdded;
  final EventCreator creator;

  Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : uid = snapshot.data()?['uid'] as String,
        title = snapshot.data()?['title'] as String,
        description = snapshot.data()?['description'] as String,
        location = snapshot.data()?['location'] as String,
        dateTime = DateTime.parse(snapshot.data()?['dateTime'] as String),
        timeAdded = DateTime.parse(snapshot.data()?['timeAdded'] as String),
        creator = EventCreator.fromJson(
            snapshot.data()?["creator"] as Map<String, dynamic>);

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "title": title,
      "description": description,
      "location": location,
      'dateTime': dateTime.toIso8601String(),
      'timeAdded': timeAdded.toIso8601String(),
      "creetor": creator.toJson(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
