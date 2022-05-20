import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class VerifyEmailViewModel extends BaseViewModel with ReactiveServiceMixin {
  VerifyEmailViewModel() {
    listenToReactiveValues([_isEmailVerified]);
  }
  final ReactiveValue<bool> _isEmailVerified = ReactiveValue<bool>(false);
  bool get isEmailVerified => _isEmailVerified.value;

  DialogService dialogService = locator<DialogService>();
  NavigationService navService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  Timer? timer;

  Future<void> init() async {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkVerification();
      });
    }
  }

  Future resendEmailVerification() async {
    authService.currentUser!.sendEmailVerification();
    notifyListeners();
  }

  Future cancelVErification() async {
    await FirebaseAuth.instance.signOut();
    navService.popUntil((route) => route.isFirst);
    notifyListeners();
  }

  Future checkVerification() async {
    timer?.cancel();
    await FirebaseAuth.instance.currentUser!.reload();
    notifyListeners();
  }

  Future openMailApp() async {
    final result = await OpenMailApp.openMailApp();

    // For iOS
    if (!result.didOpen && !result.canOpen) {
      dialogService.showDialog(
        title: 'Open Mail App',
        description: 'No mail apps installed',
        buttonTitle: 'OK',
        buttonTitleColor: AppColors.primary,
        barrierDismissible: true,
      );
    } else if (!result.didOpen && result.canOpen) {
      dialogService.showCustomDialog(
        variant: DialogType.mailApps,
        title: 'Open Mail App',
        description: 'Please select your preferred mail application',
        mainButtonTitle: 'Cancel',
        data: MailAppPickerDialog(mailApps: result.options),
      );
    }
  }

  void initialise() {
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
