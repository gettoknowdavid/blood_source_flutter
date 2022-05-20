import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/custom_user.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class VerifyEmailViewModel extends BaseViewModel with ReactiveServiceMixin {
  VerifyEmailViewModel() {
    listenToReactiveValues([_isEmailVerified]);
  }
  final ReactiveValue<bool> _isEmailVerified = ReactiveValue<bool>(false);
  bool get isEmailVerified => _isEmailVerified.value;

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
    navService.popUntil((route) => route.isFirst);
    notifyListeners();
  }

  Future checkVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();

    _isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (_isEmailVerified.value) {
      timer?.cancel();
    }

    notifyListeners();
  }

  Future continueToNext() async {
    _isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    dialogService.showCustomDialog(variant: DialogType.loading);

    final user = FirebaseAuth.instance.currentUser!.uid;
    final _ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .withConverter<CustomUser>(
            fromFirestore: CustomUser.fromFirestore,
            toFirestore: (_cs, _) => _cs.toFirestore());

    final _docSnap = await _ref.get();
    final _cUser = _docSnap.data();

    if (_isEmailVerified.value) {
      if (_cUser!.userType == UserType.donor && !_cUser.isDonorFormComplete) {
        navService.clearStackAndShow(Routes.donorFormView);
      }

      if (_cUser.userType == UserType.donor && _cUser.isDonorFormComplete) {
        navService.clearStackAndShow(Routes.homeView);
      }

      if (_cUser.userType == UserType.recipient) {
        navService.clearStackAndShow(Routes.homeView);
      }
    }
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
