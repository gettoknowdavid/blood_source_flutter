import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:stacked/stacked.dart';

class DonorDetailsViewModel extends BaseViewModel with OSMMixinObserver {
  late MapController controller;

  Future<void> init() async {
    controller = MapController(initMapWithUserPosition: true);
    controller.addObserver(this);
  }

  Future<void> mapInit(bool isReady) async {
    if (isReady) {
      await controller.setStaticPosition(
        [
          // GeoPointWithOrientation(
          //   latitude: recipient!.location!.latitude,
          //   longitude: recipient!.location!.longitude,
          // ),
        ],
        "line 2",
      );
    }
  }

  @override
  Future<void> mapIsReady(bool isReady) async => await mapInit(isReady);
}
