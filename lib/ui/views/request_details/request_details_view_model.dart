import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestDetailsViewModel extends BaseViewModel
    with ReactiveServiceMixin, OSMMixinObserver {
  RequestDetailsViewModel() {
    listenToReactiveValues([_recipient, _user]);

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

  late MapController controller;

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final ReactiveValue<BloodSourceUser?> _recipient =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get recipient => _recipient.value;

  final ReactiveValue<BloodSourceUser?> _user =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get user => _user.value;

  bool? isConnected;

  bool get compatible => user!.bloodGroup! == recipient!.bloodGroup!;

  void goToRecipientProfile() {
    _navService.navigateTo(
      Routes.profileView,
      arguments: ProfileViewArguments(user: recipient, isFromRoute: true),
    );
  }

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

  Future<void> mapInit(bool isReady) async {
    if (isReady) {
      await controller.setStaticPosition(
        [
          GeoPointWithOrientation(
            latitude: recipient!.location!.latitude,
            longitude: recipient!.location!.longitude,
          ),
        ],
        "line 2",
      );
    }
  }

  @override
  Future<void> mapIsReady(bool isReady) async => await mapInit(isReady);

  Future<void> init(Request req) async {
    setBusy(true);
    isConnected = await InternetConnectionChecker().hasConnection;

    final _recipientResult = await _storeService.getUser(req.user.uid);
    final _userResult = await _storeService.getUser(
      FirebaseAuth.instance.currentUser!.uid,
    );

    controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPointWithOrientation(
        latitude: _recipientResult!.bSUser!.location!.latitude,
        longitude: _recipientResult.bSUser!.location!.longitude,
      ),
    );

    controller.addObserver(this);

    _recipient.value = _recipientResult.bSUser;
    _user.value = _userResult!.bSUser;

    setBusy(false);

    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
