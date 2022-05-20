import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/custom_user.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends StreamViewModel<User?> {
  Timer? timer;

  NavigationService navService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  bool isVerified() {
    return authService.currentUser!.emailVerified;
  }

  @override
  Stream<User?> get stream => authService.authStateChanges;

  Future checkVerification() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        timer?.cancel();
        navService.clearStackAndShow(Routes.signInView);
      }

      if (user != null) {
        timer?.cancel();
        await FirebaseAuth.instance.currentUser!.reload();

        if (!isVerified()) {
          navService.clearStackAndShow(Routes.verifyEmailView);
        }

        if (isVerified()) {
          final user = FirebaseAuth.instance.currentUser!.uid;
          final _ref = FirebaseFirestore.instance
              .collection('users')
              .doc(user)
              .withConverter<CustomUser>(
                  fromFirestore: CustomUser.fromFirestore,
                  toFirestore: (_cs, _) => _cs.toFirestore());

          final _docSnap = await _ref.get();
          final _cUser = _docSnap.data();

          if (_cUser!.userType == UserType.donor &&
              !_cUser.isDonorFormComplete) {
            navService.clearStackAndShow(Routes.donorFormView);
            notifyListeners();
          }

          navService.clearStackAndShow(Routes.appLayoutView);
          notifyListeners();
        }
      }
    });
  }

  Future<void> init() async {
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await checkVerification();
    });
  }
}
