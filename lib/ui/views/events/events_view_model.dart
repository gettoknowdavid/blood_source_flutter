import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/event.dart';
import 'package:blood_source/services/event_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/utils/bottom_sheet_type.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EventsViewModel extends FutureViewModel<EventResult>
    with ReactiveServiceMixin {
  EventsViewModel() {
    listenToReactiveValues([_event, _verified]);

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

  final EventService _eventService = locator<EventService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final ReactiveValue<Event?> _event = ReactiveValue<Event?>(null);
  Event? get event => _event.value;

  final ReactiveValue<bool> _verified = ReactiveValue<bool>(false);
  bool get verified => _verified.value;

  bool? isConnected;

  DateTime? timeAdded;

  void openBottomSheet() {
    _bottomSheetService
        .showCustomSheet(variant: BottomSheetType.createEvent)
        .then((value) {
      if (value!.data != null) {
        _eventService.createNewEvent(value.data);
        initialise();
      }
    });
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

  Future deleteEvent(Event ev) async {
    if (data != null) {
      await _eventService.deleteEvent(ev.uid);
      final index = data!.events!.indexOf(ev);
      data!.events!.removeAt(index);
    }
    notifyListeners();
  }

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

    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Future<EventResult> futureToRun() => _eventService.getAllEvents();
}
