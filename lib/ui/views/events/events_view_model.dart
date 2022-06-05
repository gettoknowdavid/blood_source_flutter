import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/event.dart';
import 'package:blood_source/models/event_creator.dart';
import 'package:blood_source/services/event_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/utils/bottom_sheet_type.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class EventsViewModel extends StreamViewModel with ReactiveServiceMixin {
  EventsViewModel() {
    listenToReactiveValues([_event, _eventCount]);
  }

  final StoreService _storeService = locator<StoreService>();
  final EventService _eventService = locator<EventService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  final ReactiveValue<Event?> _event = ReactiveValue<Event?>(null);
  Event? get event => _event.value;

  final ReactiveValue<int> _eventCount = ReactiveValue<int>(0);
  int get eventCount => _eventCount.value;

  void openBottomSheet() {
    _bottomSheetService.showCustomSheet(variant: BottomSheetType.createEvent);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime? timeAdded;

  void setEventDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = formattedDate;
      notifyListeners();
    }
  }

  void setEventTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      timeController.text = formattedTime;
      notifyListeners();
    }
  }

  String getCreator(Event event) {
    final _uid = FirebaseAuth.instance.currentUser!.uid;

    if (_uid == event.creator.uid) {
      return 'You created this event on ${dateFormatter(event.timeAdded.toIso8601String())}.';
    } else {
      return '${event.creator.name} created this event on ${dateFormatter(event.timeAdded.toIso8601String())}.';
    }
  }

  Future createNewEvent() async {
    final _uid = FirebaseAuth.instance.currentUser!.uid;
    final _r = await _storeService.getUser(_uid);

    await _eventService.createNewEvent(Event(
      uid: const Uuid().v4(),
      title: titleController.text,
      description: descriptionController.text,
      location: locationController.text,
      date: DateTime.parse(dateController.text),
      time: timeController.text,
      timeAdded: DateTime.now(),
      creator: EventCreator(
        uid: _uid,
        name: _r!.bSUser!.name!,
        avatar: _r.bSUser!.avatar!,
      ),
    ));

    clearFields();
  }

  Future editEvent(Event event) async {
    _bottomSheetService.showCustomSheet(variant: BottomSheetType.createEvent);
    _event.value = event;

    notifyListeners();

    await _eventService.editEvent(Event(
      uid: event.uid,
      title: titleController.text,
      description: descriptionController.text,
      location: locationController.text,
      date: DateTime.parse(dateController.text),
      time: timeController.text,
      timeAdded: event.timeAdded,
      creator: event.creator,
    ));

    clearFields();
    // _event.value = null;
  }

  Future deleteEvent(Event ev) async => await _eventService.deleteEvent(ev.uid);

  Future<void> init() async {
    setBusy(true);
    _eventCount.value = _eventService.getEventsCount();
    setBusy(false);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void clearFields() {
    timeController.clear();
    descriptionController.clear();
    locationController.clear();
    dateController.clear();
    timeController.clear();
  }

  @override
  Stream get stream => _eventService.getAllEvents();
}
