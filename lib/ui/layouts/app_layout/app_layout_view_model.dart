import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view.dart';
import 'package:blood_source/ui/views/notifications/notifications_view.dart';
import 'package:blood_source/ui/views/profile/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLayoutViewModel extends IndexTrackingViewModel
    with ReactiveServiceMixin {
  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();

  UserType get userType => _storeService.bloodUser!.userType;

  void goToMakeRequestView() {
    switch (userType) {
      case UserType.recipient:
        _navService.navigateTo(Routes.requestView);
        break;
      case UserType.donor:
        _navService.navigateTo(Routes.donateView);
        break;
      default:
        null;
    }
  }

  Widget getView(int index) {
    switch (index) {
      case 0:
        return const DashboardView();
      case 1:
        return const ProfileView();
      case 2:
        return const NotificationsView();
      case 3:
        return const ProfileView();
      default:
        return const LoadingIndicator();
    }
  }

  Future<void> init() async {
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await runBusyFuture(_storeService.getUser(uid));
  }
}
