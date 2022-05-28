import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLayoutViewModel extends IndexTrackingViewModel {
  final NavigationService _navService = locator<NavigationService>();

  void goToMakeRequestView() {
    _navService.navigateTo(Routes.requestView);
  }
}
