import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel with ReactiveServiceMixin {
  SignInViewModel() {
    listenToReactiveValues([_signInError]);
  }

  void initialise() {
    notifyListeners();
  }

  final ReactiveValue<String?> _signInError = ReactiveValue<String?>(null);
  String? get signInError => _signInError.value;

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signInFormKey => _signInFormKey;

  Future<void> init() async {}

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isFormValidated() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      return false;
    } else {
      return true;
    }
  }

  void goToSignUp() => _navService.clearStackAndShow(Routes.signUpView);

  void goToForgotPassword() =>
      _navService.navigateTo(Routes.forgotPasswordView);

  void onChanged(String? value) {
    _signInError.value = null;
    notifyListeners();
  }

  Future signIn() async {
    if (_signInFormKey.currentState!.validate()) {
      _dialogService.showCustomDialog(variant: DialogType.loading);

      final _result = await _authService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (_result.user != null && _result.bSUser != null) {
        switch (_result.bSUser!.isDonorFormComplete) {
          case true:
            _navService.clearStackAndShow(Routes.appLayoutView);
            break;
          case false:
            _navService.clearStackAndShow(Routes.donorFormView);
            break;
          default:
            null;
        }
      }

      if (_result.hasError) {
        _navService.popRepeated(1);
        _signInError.value = _result.errorMessage;
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
