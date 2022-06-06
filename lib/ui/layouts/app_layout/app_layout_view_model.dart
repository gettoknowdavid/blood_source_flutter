import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/event_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view.dart';
import 'package:blood_source/ui/views/events/events_view.dart';
import 'package:blood_source/ui/views/profile/profile_view.dart';
import 'package:blood_source/ui/views/request/request_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLayoutViewModel extends IndexTrackingViewModel
    with ReactiveServiceMixin {
  AppLayoutViewModel() {
    listenToReactiveValues([_eventsCount]);
  }

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();
  final EventService _eventService = locator<EventService>();

  final ReactiveValue<int> _eventsCount = ReactiveValue<int>(0);
  int get eventsCount => _eventsCount.value;

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
      default:
        return const LoadingIndicator();
    }
  }

  Future<void> init() async {
    _eventsCount.value = _eventService.getEventsCount();
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await runBusyFuture(_storeService.getUser(uid));
  }
}
