import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel with ReactiveServiceMixin {
  void initialise() {
    notifyListeners();
  }

  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signInFormKey => _signInFormKey;

  Future<void> init() async {}

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? signInError;

  bool isFormValidated() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      return false;
    } else {
      return true;
    }
  }

  void goToSignUp() {
    navigationService.navigateTo(Routes.signUpView);
  }

  void onChanged(String? value) {
    signInError = null;
    notifyListeners();
  }

  Future signIn() async {
    if (_signInFormKey.currentState!.validate()) {
      FirebaseAuthenticationResult result = await authService.loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result.user != null) {
        navigationService.replaceWith(Routes.homeView);
        notifyListeners();
      }

      if (result.hasError) {
        switch (result.exceptionCode) {
          case 'user-not-found':
            signInError = 'Oops! We have no record of this user';
            notifyListeners();
            break;
          case 'wrong-password':
            signInError = "Something's wrong with your email or password";
            notifyListeners();
            break;
          default:
            '';
        }
        notifyListeners();
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
