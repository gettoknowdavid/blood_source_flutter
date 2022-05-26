import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends StreamViewModel<User?> {
  Timer? timer;

  NavigationService navService = locator<NavigationService>();
  // StorageService storageService = locator<StorageService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

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
    return authService.currentUser!.emailVerified;
  }

  @override
  Stream<User?> get stream => authService.authStateChanges;

  Future checkVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();

    if (!isVerified()) {
      navService.clearStackAndShow(Routes.verifyEmailView);
    }

    if (isVerified()) {
      final authUser = FirebaseAuth.instance.currentUser!;
      final _ref = FirebaseFirestore.instance
          .collection('users')
          .doc(authUser.uid)
          .withConverter<BloodSourceUser>(
              fromFirestore: BloodSourceUser.fromFirestore,
              toFirestore: (_cs, _) => _cs.toFirestore());

      final _docSnap = await _ref.get();
      final _user = _docSnap.data();

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
}
