import 'dart:async';
import 'dart:io';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/contact_button_model.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DonateViewModel extends BaseViewModel {
  DonateViewModel() {
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

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool? isConnected;

  List<ContactButtonModel> buttons = contactButtonList;

  void gotToDonorProfile(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.profileView,
      arguments: ProfileViewArguments(user: donor, isFromRoute: true),
    );
  }

  void getAction(ContactType contactType, BloodSourceUser donor) async {
    switch (contactType) {
      case ContactType.call:
        final urlString = Uri(scheme: 'tel', path: donor.phone);
        await launchUrl(urlString);
        break;
      case ContactType.email:
        EmailContent email =
            EmailContent(to: [donor.email!], subject: 'Hello!');

        OpenMailAppResult result = await OpenMailApp.composeNewEmailInMailApp(
          nativePickerTitle: 'Select email app to compose',
          emailContent: email,
        );

        if (!result.didOpen && !result.canOpen) {
          _dialogService.showDialog(
            title: 'Open Mail App',
            description: 'No mail apps installed',
            buttonTitle: 'OK',
            buttonTitleColor: AppColors.primary,
            barrierDismissible: true,
          );
        } else if (!result.didOpen && result.canOpen) {
          _dialogService.showCustomDialog(data: (_) {
            return MailAppPickerDialog(mailApps: result.options);
          });
        }
        break;
      case ContactType.whatsapp:
        final phone = "+234${donor.phone}";
        final androidUrl = "whatsapp://send?phone=$phone&text=Hello";
        final iOSUrl = "https://wa.me/$phone?text=${Uri.parse("Hello")}";

        if (Platform.isIOS) {
          await launchUrlString(iOSUrl);
        } else {
          await launchUrlString(androidUrl);
        }
        break;
      case ContactType.telegram:
        final phone = "+234${donor.phone}";
        final androidUrl = "https://telegram.me/$phone?text=Hello";
        final iOSUrl = "https://telegram.me/$phone?text=${Uri.parse("Hello")}";

        if (Platform.isIOS) {
          await launchUrlString(iOSUrl);
        } else {
          await launchUrlString(androidUrl);
        }
        break;
      default:
        null;
    }
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
