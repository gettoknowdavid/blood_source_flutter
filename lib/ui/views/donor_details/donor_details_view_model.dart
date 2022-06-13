import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonorDetailsViewModel extends ReactiveViewModel
    with ReactiveServiceMixin, OSMMixinObserver {
  DonorDetailsViewModel() {
    listenToReactiveValues([_geoPoint]);

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

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  BloodSourceUser get recipient => _storeService.bsUser!;

  final ReactiveValue<GeoPointWithOrientation?> _geoPoint =
      ReactiveValue<GeoPointWithOrientation?>(null);
  GeoPointWithOrientation? get geoPoint => _geoPoint.value;

  late MapController controller;

  bool isMapReady = false;

  bool? isConnected;

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
    isConnected = await InternetConnectionChecker().hasConnection;

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

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
