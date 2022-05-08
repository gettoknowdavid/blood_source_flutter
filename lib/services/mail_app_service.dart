import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:logger/logger.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked_services/stacked_services.dart';

class MailAppService {
  /// An Instance of Logger that can be used to log out what's happening in the service
  Logger? log;

  final DialogService _dialogService = locator<DialogService>();

  Future openMailApp() async {
    final result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
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
  }
}
