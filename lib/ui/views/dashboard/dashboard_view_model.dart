import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends ReactiveViewModel {
  Future longUpdateStuff() async {
    // var result = await runBusyFuture();
    // return result;
  }

  Future<void> init() async {}

  final AuthService _authService = locator<AuthService>();
  User get user => _authService.currentUser!;

  String get firstName => user.displayName.toString().split(" ").first;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
