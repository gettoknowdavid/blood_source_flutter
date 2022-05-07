import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel with ReactiveServiceMixin {
  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  bool _isObscurePassword = false;
  bool get isObscurePassword => _isObscurePassword;

  Future<void> init() async {}

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // @override
  // void initialise() {
  //   notifyListeners();
  // }

  void toggleObscurePassword() {
    _isObscurePassword = !_isObscurePassword;
    notifyListeners();
  }

  void goToSignUp() {
    navigationService.navigateTo(Routes.signUpView);
  }

  Future signIn() async {
    await authService.loginWithEmail(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (authService.hasUser) {
      navigationService.navigateTo(Routes.homeView);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
