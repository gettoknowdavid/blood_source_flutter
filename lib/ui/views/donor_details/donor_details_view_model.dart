import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonorDetailsViewModel extends ReactiveViewModel
    with ReactiveServiceMixin, OSMMixinObserver {
  DonorDetailsViewModel() {
    listenToReactiveValues([_geoPoint]);
  }

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();

  BloodSourceUser get recipient => _storeService.bsUser!;

  final ReactiveValue<GeoPointWithOrientation?> _geoPoint =
      ReactiveValue<GeoPointWithOrientation?>(null);
  GeoPointWithOrientation? get geoPoint => _geoPoint.value;

  late MapController controller;

  bool isMapReady = false;

  void goToDonate(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.donateView,
      arguments: DonateViewArguments(donor: donor),
    );
  }

  void goToDonorProfile(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.profileView,
      arguments: ProfileViewArguments(user: donor, isFromRoute: true),
    );
  }

  Future<void> init(BloodSourceUser donor) async {
    setBusy(true);

    _geoPoint.value = GeoPointWithOrientation(
      latitude: donor.location!.latitude,
      longitude: donor.location!.longitude,
    );
    controller = MapController(initMapWithUserPosition: true);
    controller.addObserver(this);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _storeService.getUser(uid);
    setBusy(false);
    notifyListeners();
  }

  Future<void> mapInit(bool isReady) async {
    if (isReady && geoPoint != null) {
      await controller.setStaticPosition([_geoPoint.value!], "line 2");
    }
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    await mapInit(isReady);
    isMapReady = true;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
