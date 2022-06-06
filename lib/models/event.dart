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
    required this.date,
    required this.time,
    required this.timeAdded,
    required this.creator,
  });

  final String uid;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String time;
  final DateTime timeAdded;
  final EventCreator creator;

  Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : uid = snapshot.data()?['uid'] as String,
        title = snapshot.data()?['title'] as String,
        description = snapshot.data()?['description'] as String,
        location = snapshot.data()?['location'] as String,
        date = DateTime.parse(
            (snapshot.data()?['date'] as Timestamp).toDate().toString()),
        time = snapshot.data()?['time'] as String,
        timeAdded = DateTime.parse(
            (snapshot.data()?['timeAdded'] as Timestamp).toDate().toString()),
        creator = EventCreator.fromJson(
            snapshot.data()?["creator"] as Map<String, dynamic>);

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "title": title,
      "description": description,
      "location": location,
      'date': date,
      'time': time,
      'timeAdded': timeAdded,
      "creator": creator.toJson(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
