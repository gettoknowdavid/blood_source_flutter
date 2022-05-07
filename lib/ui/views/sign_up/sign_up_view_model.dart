import 'package:blood_source/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends StreamViewModel with ReactiveServiceMixin {
  Future<void> init() async {}

  NavigationService? navigationService = locator<NavigationService>();
  FirebaseAuthenticationService? authService =
      locator<FirebaseAuthenticationService>();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;

  bool _isPasswordObscure = false;
  bool get isPasswordObscure => _isPasswordObscure;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleObscurity() {
    _isPasswordObscure = !_isPasswordObscure;
    notifyListeners();
  }

  Future signUp() async {
    await authService!.createAccountWithEmail(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    authService!.authStateChanges.listen((User? user) {
      if (user != null) {
        user.updateDisplayName(nameController.text.trim());
      }
    });

    // if (signUpFormKey.currentState!.validate()) {
    //   // sign up logic
    //   return true;
    // }
  }

  @override
  void initialise() {
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Stream get stream => throw UnimplementedError();
}
