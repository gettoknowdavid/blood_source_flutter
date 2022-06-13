import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:blood_source/models/blood_source_user.dart';

class VerifyEmailViewModel extends ReactiveViewModel
    with ReactiveServiceMixin, Initialisable {
  VerifyEmailViewModel() {
    listenToReactiveValues([_isEmailVerified]);
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

  final ReactiveValue<bool> _isEmailVerified = ReactiveValue<bool>(false);
  bool get isEmailVerified => _isEmailVerified.value;

  StoreService storeService = locator<StoreService>();
  StorageService storageService = locator<StorageService>();
  DialogService dialogService = locator<DialogService>();
  NavigationService navService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  BloodSourceUser get bsUser => storeService.bsUser!;

  Timer? timer;

  bool? isConnected;

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

      if (bsUser.userType == UserType.donor && !bsUser.isDonorFormComplete) {
        navService.clearStackAndShow(Routes.donorFormView);
        notifyListeners();
      } else {
        navService.clearStackAndShow(
          Routes.editProfileView,
          arguments: EditProfileViewArguments(user: bsUser, isFirstEdit: true),
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

  @override
  List<ReactiveServiceMixin> get reactiveServices => [storeService];

  @override
  void initialise() async {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkVerification();
      });
    }
  }

  Future<void> init() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    subscription.cancel();
    super.dispose();
  }
}
