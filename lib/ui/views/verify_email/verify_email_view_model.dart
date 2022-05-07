import 'package:stacked/stacked.dart';

class VerifyEmailViewModel extends BaseViewModel with ReactiveServiceMixin {
  Future<void> init() async {}

  bool isVerified = false;

  @override
  void initialise() {
    notifyListeners();
  }
}
