import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/storage_keys.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:blood_source/models/blood_source_user.dart';

class SplashViewModel extends ReactiveViewModel with Initialisable {
  Timer? timer;

  int? initScreen;
  int? initEdit;

  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();
  final AuthService _authService = locator<AuthService>();

  BloodSourceUser? get bsUser => _storeService.bsUser;
  bool? get isAuth => _authService.isAuth;

  Future<void> init() async {}

  @override
  void initialise() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt(StorageKeys.initScreen);
    initEdit = preferences.getInt(StorageKeys.initEdit);
    preferences.setInt(StorageKeys.initScreen, 1);

    Future.delayed(const Duration(seconds: 5)).then((_) async {
      switch (initScreen) {
        case 0:
          _navService.replaceWith(Routes.onBoardingView);
          break;
        case null:
          _navService.replaceWith(Routes.onBoardingView);
          break;
        case 1:
          if (_authService.hasUser) {
            await _storeService.getUser(_authService.userUid!);

            if (bsUser!.userType == UserType.donor &&
                !bsUser!.isDonorFormComplete) {
              _navService.replaceWith(Routes.donorFormView);
            }

            if (bsUser!.userType == UserType.recipient &&
                bsUser!.initEdit != 1) {
              _navService.replaceWith(
                Routes.editProfileView,
                arguments: EditProfileViewArguments(
                  user: bsUser!,
                  isFirstEdit: true,
                ),
              );
            }

            _navService.replaceWith(Routes.appLayoutView);
          } else {
            _navService.replaceWith(Routes.signInView);
          }
          break;
        default:
          _navService.replaceWith(Routes.onBoardingView);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_authService, _storeService];
}
