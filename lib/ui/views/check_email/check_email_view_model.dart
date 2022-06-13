import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckEmailViewModel extends BaseViewModel {
  CheckEmailViewModel() {
    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isConnected = true;
          notifyListeners();
          break;
        case InternetConnectionStatus.disconnected:
          isConnected = false;
          notifyListeners();
          break;
      }
    });
  }

  late StreamSubscription<InternetConnectionStatus> subscription;

  bool? isConnected;

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  Future openMailApp() async {
    final result = await OpenMailApp.openMailApp();

    // For iOS
    if (!result.didOpen && !result.canOpen) {
      _dialogService.showDialog(
        title: 'Open Mail App',
        description: 'No mail apps installed',
        buttonTitle: 'OK',
        buttonTitleColor: AppColors.primary,
        barrierDismissible: true,
      );
    } else if (!result.didOpen && result.canOpen) {
      _dialogService.showCustomDialog(
        variant: DialogType.mailApps,
        title: 'Open Mail App',
        description: 'Please select your preferred mail application',
        mainButtonTitle: 'Cancel',
        data: MailAppPickerDialog(mailApps: result.options),
      );
    }
  }

  Future goBackToSignIn() async {
    _navService.clearStackAndShow(Routes.signInView);
  }

  Future goBackToForgotPassword() async {
    _navService.replaceWith(Routes.forgotPasswordView);
  }

  Future<void> checkConnectivity() async {
    bool isConn = await InternetConnectionChecker().hasConnection;
    switch (isConn) {
      case true:
        _snackbarService.showCustomSnackBar(
          message: 'Yay! You\'re connected!',
          variant: SnackbarType.positive,
          duration: const Duration(seconds: 3),
        );
        notifyListeners();
        break;
      case false:
        _snackbarService.showCustomSnackBar(
          message: 'We are convinced you\'re disconnected. Try again.',
          variant: SnackbarType.negative,
          duration: const Duration(seconds: 3),
        );
        notifyListeners();
        break;
      default:
        null;
    }
  }

  Future<void> init() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
