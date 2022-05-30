import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:blood_source/models/blood_source_user.dart';

class VerifyEmailViewModel extends BaseViewModel with ReactiveServiceMixin {
  VerifyEmailViewModel() {
    listenToReactiveValues([_isEmailVerified]);
  }
  final ReactiveValue<bool> _isEmailVerified = ReactiveValue<bool>(false);
  bool get isEmailVerified => _isEmailVerified.value;

  StorageService storageService = locator<StorageService>();
  DialogService dialogService = locator<DialogService>();
  NavigationService navService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  Timer? timer;

  Future<void> init() async {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkVerification();
      });
    }
  }

  Future resendEmailVerification() async {
    authService.currentUser!.sendEmailVerification();
    notifyListeners();
  }

  Future cancelVErification() async {
    await FirebaseAuth.instance.signOut();
    navService.clearStackAndShow(Routes.signInView);
    notifyListeners();
  }

  Future checkVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();
    _isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (_isEmailVerified.value == true) {
      timer?.cancel();

      final authUser = FirebaseAuth.instance.currentUser!;
      final _ref = FirebaseFirestore.instance
          .collection('users')
          .doc(authUser.uid)
          .withConverter<BloodSourceUser>(
              fromFirestore: BloodSourceUser.fromFirestore,
              toFirestore: (_cs, _) => _cs.toFirestore());

      final _docSnap = await _ref.get();
      final _user = _docSnap.data();

      storageService.saveToDisk(authUser.uid, _user!.toJson());

      if (_user.userType == UserType.donor && !_user.isDonorFormComplete) {
        navService.clearStackAndShow(Routes.donorFormView);
        notifyListeners();
      }

      if (_user.userType == UserType.donor && _user.isDonorFormComplete) {
        navService.clearStackAndShow(Routes.appLayoutView);
        notifyListeners();
      }

      if (_user.userType == UserType.recipient) {
        navService.clearStackAndShow(
          Routes.editProfileView,
          arguments: EditProfileViewArguments(user: _user, isFirstEdit: true),
        );
        notifyListeners();
      }
    }

    notifyListeners();
  }

  Future openMailApp() async {
    final result = await OpenMailApp.openMailApp();

    // For iOS
    if (!result.didOpen && !result.canOpen) {
      dialogService.showDialog(
        title: 'Open Mail App',
        description: 'No mail apps installed',
        buttonTitle: 'OK',
        buttonTitleColor: AppColors.primary,
        barrierDismissible: true,
      );
    } else if (!result.didOpen && result.canOpen) {
      dialogService.showCustomDialog(
        variant: DialogType.mailApps,
        title: 'Open Mail App',
        description: 'Please select your preferred mail application',
        mainButtonTitle: 'Cancel',
        data: MailAppPickerDialog(mailApps: result.options),
      );
    }
  }

  void initialise() {
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
