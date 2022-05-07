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

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signInFormKey => _signInFormKey;

  Future<void> init() async {}

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void goToSignUp() {
    navigationService.navigateTo(Routes.signUpView);
  }

  emailValidator(text) {
    if (text == null || text.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  passwordValidator(text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  Future signIn() async {
    if (_signInFormKey.currentState!.validate()) {
      await authService.loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }

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
