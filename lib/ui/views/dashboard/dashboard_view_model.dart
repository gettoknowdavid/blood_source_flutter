import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/location_service.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends ReactiveViewModel {
  Future<void> init() async {}

  LocationService locationService = locator<LocationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [locationService];
}
