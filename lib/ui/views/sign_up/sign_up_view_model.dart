import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/ui/shared/setup_snack_bar_ui.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:blood_source/utils/password_rules.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel with ReactiveServiceMixin {
  SignUpViewModel() {
    listenToReactiveValues([_rules, _rulesVisibility, _ruleColor, _userType]);

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
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ReactiveValue<List<Map>> _rules =
      ReactiveValue<List<Map>>(passwordRules);
  final ReactiveValue<bool> _rulesVisibility = ReactiveValue<bool>(false);
  final ReactiveValue<Color> _ruleColor =
      ReactiveValue<Color>(AppColors.swatch.shade900);
  final ReactiveValue<UserType> _userType =
      ReactiveValue<UserType>(UserType.donor);

  bool? isConnected;
  String? signUpError;
  List<Map> get rules => _rules.value;
  bool get rulesVisibility => _rulesVisibility.value;
  Color get ruleColor => _ruleColor.value;
  UserType get userType => _userType.value;

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

  bool isPasswordOk() {
    return ((!(passwordController.text.contains(nameController.text) ||
            passwordController.text.contains(emailController.text))) &&
        RegExp("^(?=.*?[A-Z]).{8,}\$").hasMatch(passwordController.text) &&
        !RegExp("^[a-zA-Z0-9 ]*\$").hasMatch(passwordController.text));
  }

  bool isFormValidated() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        !isPasswordOk() ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      return false;
    } else {
      return true;
    }
  }

  void onChanged(String? value) {
    signUpError = null;
    notifyListeners();
  }

  void onPasswordChanged(String? value) {
    _rulesVisibility.value = passwordController.text.isNotEmpty ? true : false;
    notifyListeners();
  }

  void Function(UserType?)? onUserTypeChanged(UserType? type) {
    _userType.value = type!;
    notifyListeners();
    return null;
  }

  Future signUp() async {
    if (_signUpFormKey.currentState!.validate()) {
      _dialogService.showCustomDialog(variant: DialogType.loading);

      final result = await _authService.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        gender: Gender.none,
        isDonorFormComplete:
            _userType.value == UserType.recipient ? true : false,
        userType: _userType.value,
      );

      if (result.user != null) {
        _navService.clearStackAndShow(Routes.verifyEmailView);
        notifyListeners();
      }

      if (result.hasError) {
        _navService.popRepeated(1);
        signUpError = result.errorMessage;
        notifyListeners();
      }
    }
  }

  Future<void> init() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    subscription.cancel();
    super.dispose();
  }
}
