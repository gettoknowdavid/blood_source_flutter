import 'package:blood_source/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class EventService with ReactiveServiceMixin {
  EventService() {
    listenToReactiveValues([_eventsCount]);
  }

  final ReactiveValue<int> _eventsCount = ReactiveValue<int>(0);
  int get eventsCount => _eventsCount.value;

  final eventRef = FirebaseFirestore.instance
      .collection('events')
      .withConverter<Event>(
          fromFirestore: Event.fromFirestore,
          toFirestore: (e, _) => e.toFirestore());

  Future<void> createNewEvent(Event event) async {
    await eventRef
        .doc(event.uid)
        .set(event)
        .timeout(const Duration(seconds: 10));
    notifyListeners();
  }

  Future<void> deleteEvent(String eventUid) async {
    await eventRef.doc(eventUid).delete().timeout(const Duration(seconds: 6));
    notifyListeners();
  }

  Future<void> editEvent(Event event) async {
    return await eventRef.doc(event.uid).update(event.toFirestore());
  }

  Stream<QuerySnapshot<Event?>> getAllEvents() {
    return eventRef
        .orderBy('timeAdded', descending: true)
        .snapshots()
        .timeout(const Duration(seconds: 8));
  }

  int getEventsCount() {
    eventRef.snapshots().listen((event) {
      _eventsCount.value = event.docs.length;
    });
    return _eventsCount.value;
  }
}

class EventResult {
  final Event? event;
  final List<Event>? events;

  final String? errorMessage;

  EventResult({this.event, this.events}) : errorMessage = null;

  EventResult.error({this.errorMessage})
      : event = null,
        events = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  bool get isEventsEmpty => events == null && events!.isEmpty;
}
