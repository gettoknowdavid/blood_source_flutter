import 'dart:math';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';

class RequestDetailsViewModel extends BaseViewModel
    with ReactiveServiceMixin, OSMMixinObserver {
  RequestDetailsViewModel() {
    listenToReactiveValues([_user]);
  }
  MapController controller = MapController();

  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<BloodSourceUser?> _user =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get user => _user.value;

  Future<void> init(Request req) async {
    setBusy(true);
    final result = await _storeService.getUser(req.user.uid);
    setBusy(false);
    _user.value = result!.bSUser;

    controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: user!.location!.latitude,
        longitude: user!.location!.longitude,
      ),
      // areaLimit: BoundingBox(
      //   east: 10.4922941,
      //   north: 47.8084648,
      //   south: 45.817995,
      //   west: 5.9559113,
      // ),
    );

    controller.addObserver(this);

    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    var result = await runBusyFuture(mapIsInitialized());
    return result;
  }

  Future<void> mapIsInitialized() async {
    await controller.setStaticPosition(
      [
        GeoPointWithOrientation(
          latitude: user!.location!.latitude,
          longitude: user!.location!.longitude,
        ),
      ],
      "line 2",
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }

  @override
  void dispose() {
    //controller.listenerMapIsReady.removeListener(mapIsInitialized);
    controller.dispose();
    super.dispose();
  }
}
