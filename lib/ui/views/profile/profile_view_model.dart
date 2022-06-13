import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/ui/views/edit_profile/edit_profile_view.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends ReactiveViewModel {
  ProfileViewModel() {
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

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final StoreService _storeService = locator<StoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

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
    await longUpdateStuff();
  }

  BloodSourceUser get user => _storeService.bsUser!;

  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
    var result = await runBusyFuture(getProfile());
    return result;
  }

  Future<BloodSourceUser> getProfile() async {
    final result = await _storeService.getUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return result!.bSUser!;
  }

  Future<void> signOut() async {
    await _authService.singOut();
    _dialogService.showCustomDialog(variant: DialogType.loading);

    if (_authService.currentUser == null) {
      _navService.clearStackAndShow(Routes.signInView);
    }
  }

  void goToEditProfile(BloodSourceUser user) => _navService.navigateToView(
        EditProfileView(user: user),
      );

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
