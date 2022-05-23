import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  Future<void> init() async {}

  final User user = FirebaseAuth.instance.currentUser!;
}
