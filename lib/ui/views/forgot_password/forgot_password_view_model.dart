import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
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

  void onChanged(String? value) {
    notifyListeners();
  }

  Future submit() async {
    if (_forgotPasswordForm.currentState!.validate()) {
      final result = await authService.sendResetPasswordLink(
        emailController.text.trim(),
      );

      if (result) {
        navigationService.replaceWith(Routes.checkEmailView);
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
