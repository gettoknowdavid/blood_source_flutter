import 'package:blood_source/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class HomeViewModel extends BaseViewModel {
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  Future<void> init() async {}

  Future signOut() async {
    await authService.logout();
  }
}
