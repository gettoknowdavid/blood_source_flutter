import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/views/edit_profile/edit_profile_view.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:logger/logger.dart';

class ProfileViewModel extends ReactiveViewModel {
  final Logger _logger = Logger();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final AuthService _authService = locator<AuthService>();
  final StoreService _storeService = locator<StoreService>();

  Future<void> init() async {
    await longUpdateStuff();
  }

  BloodSourceUser get user => _storeService.bloodUser!;

  Future longUpdateStuff() async {
    // Sets busy to true before starting future and sets it to false after executing
    // You can also pass in an object as the busy object. Otherwise it'll use the ViewModel
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
}
