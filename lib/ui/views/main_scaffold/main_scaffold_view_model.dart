import 'package:blood_source/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class MainScaffoldViewModel extends StreamViewModel<User?> {
  Future<void> init() async {}

  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  @override
  Stream<User?> get stream => authService.authStateChanges;
}
