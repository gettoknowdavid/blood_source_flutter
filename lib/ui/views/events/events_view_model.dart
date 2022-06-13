import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/event.dart';
import 'package:blood_source/models/event_creator.dart';
import 'package:blood_source/services/event_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/utils/bottom_sheet_type.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class EventsViewModel extends FutureViewModel<EventResult>
    with ReactiveServiceMixin {
  EventsViewModel() {
    listenToReactiveValues([_event, _eventCount, _verified]);

    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isConnected = true;
          notifyListeners();
          break;
        case InternetConnectionStatus.disconnected:
          isConnected = false;
          notifyListeners();
          break;
      }
    });
  }

  late StreamSubscription<InternetConnectionStatus> subscription;

  final StoreService _storeService = locator<StoreService>();
  final EventService _eventService = locator<EventService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final ReactiveValue<Event?> _event = ReactiveValue<Event?>(null);
  Event? get event => _event.value;

  final ReactiveValue<int> _eventCount = ReactiveValue<int>(0);
  int get eventsCount => _eventService.eventsCount;

  final ReactiveValue<bool> _verified = ReactiveValue<bool>(false);
  bool get verified => _verified.value;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  bool? isConnected;

  DateTime? timeAdded;

  void openBottomSheet() {
    _bottomSheetService.showCustomSheet(variant: BottomSheetType.createEvent);
  }

  bool formVerified() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

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

  bool isEventBelongToUser(Event ev) {
    final _uid = FirebaseAuth.instance.currentUser!.uid;
    if (_uid == ev.creator.uid) {
      return true;
    } else {
      return false;
    }
  }

  String getCreator(Event ev) {
    final _uid = FirebaseAuth.instance.currentUser!.uid;

    if (_uid == ev.creator.uid) {
      return 'You created this event on ${dateFormatter(ev.timeAdded.toIso8601String())}.';
    } else {
      return '${ev.creator.name} created this event on ${dateFormatter(ev.timeAdded.toIso8601String())}.';
    }
  }

  Future createNewEvent() async {
    if (formVerified()) {
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
      notifyListeners();
      _eventCount.value = _eventService.getEventsCount();
      clearFields();
    } else {
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.negative,
        message: 'All items are required. Please fill them in.',
      );
    }
  }

  // Future editEvent(Event event) async {
  //   _bottomSheetService.showCustomSheet(variant: BottomSheetType.createEvent);
  //   _event.value = event;

  //   notifyListeners();

  //   await _eventService.editEvent(Event(
  //     uid: event.uid,
  //     title: titleController.text,
  //     description: descriptionController.text,
  //     location: locationController.text,
  //     date: DateTime.parse(dateController.text),
  //     time: timeController.text,
  //     timeAdded: event.timeAdded,
  //     creator: event.creator,
  //   ));

  //   clearFields();
  //   // _event.value = null;
  // }

  Future deleteEvent(Event ev) async => await _eventService.deleteEvent(ev.uid);

  Future<void> checkConnectivity() async {
    bool isConn = await InternetConnectionChecker().hasConnection;
    switch (isConn) {
      case true:
        _snackbarService.showCustomSnackBar(
          message: 'Yay! You\'re connected!',
          variant: SnackbarType.positive,
          duration: const Duration(seconds: 3),
        );
        notifyListeners();
        break;
      case false:
        _snackbarService.showCustomSnackBar(
          message: 'We are convinced you\'re disconnected. Try again.',
          variant: SnackbarType.negative,
          duration: const Duration(seconds: 3),
        );
        notifyListeners();
        break;
      default:
        null;
    }
  }

  Future<void> init() async {
    isConnected = await InternetConnectionChecker().hasConnection;

    _eventCount.value = _eventService.getEventsCount();

    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    subscription.cancel();
    super.dispose();
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    dateController.clear();
    timeController.clear();
  }

  @override
  Future<EventResult> futureToRun() => _eventService.getAllEvents();
}
