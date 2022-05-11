import 'package:blood_source/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends StreamViewModel<User?> {
  Future<void> init() async {}

  NavigationService navService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  bool isVerified() {
    return authService.currentUser!.emailVerified;
  }

  @override
  Stream<User?> get stream => authService.authStateChanges;
}
