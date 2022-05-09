import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends BaseViewModel with ReactiveServiceMixin {
  Future<void> init() async {}

  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  final GlobalKey<FormState> _forgotPasswordForm = GlobalKey<FormState>();
  GlobalKey<FormState> get forgotPasswordForm => _forgotPasswordForm;

  final TextEditingController emailController = TextEditingController();

  bool isFormValidated() {
    if (emailController.text.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      return false;
    } else {
      return true;
    }
  }

  String? signInError;

  void onChanged(String? value) {
    signInError = null;
    notifyListeners();
  }

  Future submit() async {
    if (_forgotPasswordForm.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        navigationService.navigateTo(Routes.checkEmailView);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          signInError = 'Oops! We have no record of this user';
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void initialise() {
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
