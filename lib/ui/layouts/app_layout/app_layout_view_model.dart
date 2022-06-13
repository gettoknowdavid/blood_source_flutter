import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/services/event_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/views/about/about_view.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view.dart';
import 'package:blood_source/ui/views/events/events_view.dart';
import 'package:blood_source/ui/views/profile/profile_view.dart';
import 'package:blood_source/ui/views/request/request_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLayoutViewModel extends IndexTrackingViewModel
    with ReactiveServiceMixin, Initialisable {
  AppLayoutViewModel() {
    InternetConnectionChecker().onStatusChange.listen((status) {
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

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();
  final EventService _eventService = locator<EventService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool? isConnected;

  int get eventsCount => _eventService.eventsCount;

  UserType get userType => _storeService.bsUser!.userType;

  void goToMakeRequestView() => _navService.navigateTo(Routes.requestView);

  Widget getView(int index) {
    switch (index) {
      case 0:
        return const DashboardView();
      case 1:
        return const ProfileView();
      case 2:
        return const RequestView();
      case 3:
        return const EventsView();
      case 4:
        return const AboutView();
      default:
        return const EmptyWidget(message: 'Sorry, this page does not exist');
    }
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
    notifyListeners();
  }

  Future<void> init() async {
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await runBusyFuture(_storeService.getUser(uid));
  }

  @override
  void initialise() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    _eventService.getEventsCount();
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_eventService];
}
