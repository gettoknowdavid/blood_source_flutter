import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/location_service.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends ReactiveViewModel {
  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(getLocation());
    return result;
  }

  Future<void> init() async {
    await longUpdateStuff();
  }

  LocationService locationService = locator<LocationService>();

  Future getLocation() async {
    await locationService.getPlace();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [locationService];
}
