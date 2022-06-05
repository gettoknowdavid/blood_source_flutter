import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';

class RequestDetailsViewModel extends BaseViewModel
    with ReactiveServiceMixin, OSMMixinObserver {
  RequestDetailsViewModel() {
    listenToReactiveValues([_recipient, _user]);
  }

  late MapController controller;

  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<BloodSourceUser?> _recipient =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get recipient => _recipient.value;

  final ReactiveValue<BloodSourceUser?> _user =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get user => _user.value;

  bool get compatible => user!.bloodGroup! == recipient!.bloodGroup!;

  Future<void> init(Request req) async {
    setBusy(true);
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

    setBusy(false);

    _recipient.value = _recipientResult.bSUser;
    _user.value = _userResult!.bSUser;

    notifyListeners();
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
}
