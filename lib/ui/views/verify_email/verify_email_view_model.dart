import 'package:stacked/stacked.dart';

class VerifyEmailViewModel extends StreamViewModel with ReactiveServiceMixin {
  Future<void> init() async {}

  @override
  Stream get stream => throw UnimplementedError();

  bool isVerified = false;

  @override
  void initialise() {
    notifyListeners();
  }
}
