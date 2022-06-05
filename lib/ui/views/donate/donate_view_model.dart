import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/contact_button_model.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateViewModel extends BaseViewModel with ReactiveServiceMixin {
  DonateViewModel() {}

  final DialogService _dialogService = locator<DialogService>();

  List<ContactButtonModel> buttons = contactButtonList;

  Future<void> init() async {}

  void getAction(ContactType contactType, BloodSourceUser user) async {
    switch (contactType) {
      case ContactType.call:
        final urlString = Uri(scheme: 'tel', path: user.phone);
        await launchUrl(urlString);
        break;
      case ContactType.email:
        EmailContent email = EmailContent(to: [user.email!], subject: 'Hello!');

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
        final url = Uri(path: "https://wa.me/?text=Your%20text%20here");
        await launchUrl(url);
        break;
      case ContactType.telegram:
        final url = Uri(path: "https://telegram.me/${user.phone}");
        await launchUrl(url);
        break;
      default:
        null;
    }
  }

  // final StoreService _storeService = locator<StoreService>();
  // final NavigationService _navService = locator<NavigationService>();
}
