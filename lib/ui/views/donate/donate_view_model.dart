import 'dart:io';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/contact_button_model.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DonateViewModel extends BaseViewModel with ReactiveServiceMixin {
  DonateViewModel() {}

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();

  List<ContactButtonModel> buttons = contactButtonList;

  Future<void> init() async {}

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

  // final StoreService _storeService = locator<StoreService>();
  // final NavigationService _navService = locator<NavigationService>();
}
