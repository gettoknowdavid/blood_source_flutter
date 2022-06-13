import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/donor_service.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonorViewModel extends StreamViewModel<QuerySnapshot<BloodSourceUser?>> {
  DonorViewModel() {
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

  final DonorService _donorService = locator<DonorService>();
  final RequestService _requestService = locator<RequestService>();
  final NavigationService _navService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool? isConnected;

  Request? get request => _requestService.request;

  bool compatible = true;

  void goToDonorDetails(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.donorDetailsView,
      arguments: DonorDetailsViewArguments(donor: donor),
    );
  }

  void goToDonorProfile(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.profileView,
      arguments: ProfileViewArguments(user: donor, isFromRoute: true),
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
        break;
      case false:
        _snackbarService.showCustomSnackBar(
          message: 'We are convinced you\'re disconnected. Try again.',
          variant: SnackbarType.negative,
          duration: const Duration(seconds: 3),
        );
        break;
      default:
        null;
    }
  }

  Future<void> init() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  void onChangeCompatible() {
    compatible = !compatible;
    notifyListeners();
    notifySourceChanged();
  }

  Future addRequest(Request request) async {
    await _requestService.addRequest(request);
    _dialogService
        .showDialog(
          title: 'Successfully Added',
          description: 'Your blood request has been made.',
        )
        .then((value) => _navService.popRepeated(1));
  }

  @override
  Stream<QuerySnapshot<BloodSourceUser?>> get stream => compatible
      ? _donorService.getCompatibleDonors(request!)
      : _donorService.getDonors();

      @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
