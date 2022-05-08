import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/mail_app_service.dart';
import 'package:stacked/stacked.dart';

class CheckEmailViewModel extends BaseViewModel {
  MailAppService mailService = locator<MailAppService>();

  Future<void> init() async {}

  Future openMailApp() async {
    await mailService.openMailApp();
  }

  void initialise() {
    notifyListeners();
  }
}
