import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends StreamViewModel<User?> {
  Timer? timer;

  StoreService storeService = locator<StoreService>();
  NavigationService navService = locator<NavigationService>();

  bool hasAccess() {
    bool access = false;
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        access = true;
      } else {
        access = false;
      }
    });
    return access;
  }

  bool isVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }

  Future checkVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();

    if (!isVerified()) {
      navService.clearStackAndShow(Routes.verifyEmailView);
    }

    if (isVerified()) {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final result = await storeService.getUser(uid);
      final _user = result!.bSUser;

      if (_user!.userType == UserType.donor && !_user.isDonorFormComplete) {
        navService.clearStackAndShow(Routes.donorFormView);
        notifyListeners();
      }

      navService.clearStackAndShow(Routes.appLayoutView);
      notifyListeners();
    }
  }

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        navService.clearStackAndShow(Routes.appLayoutView);
      } else {
        navService.clearStackAndShow(Routes.signInView);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Stream<User?> get stream => FirebaseAuth.instance.authStateChanges();
}
