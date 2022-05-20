import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/custom_user.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel with ReactiveServiceMixin {
  void initialise() {
    notifyListeners();
  }

  DialogService dialogService = locator<DialogService>();
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
    notifyListeners();
  }

  void goToForgotPassword() {
    navigationService.navigateTo(Routes.forgotPasswordView);
    notifyListeners();
  }

  void onChanged(String? value) {
    signInError = null;
    notifyListeners();
  }

  Future signIn() async {
    if (_signInFormKey.currentState!.validate()) {
      dialogService.showCustomDialog(variant: DialogType.loading);

      FirebaseAuthenticationResult result = await authService.loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null) {
          final _ref = FirebaseFirestore.instance
              .collection('users')
              .doc(result.user!.uid)
              .withConverter<CustomUser>(
                  fromFirestore: CustomUser.fromFirestore,
                  toFirestore: (_cs, _) => _cs.toFirestore());

          final _docSnap = await _ref.get();
          final _cUser = _docSnap.data();

          switch (_cUser!.isDonorFormComplete) {
            case true:
              navigationService.clearStackAndShow(Routes.homeView);
              notifyListeners();
              break;
            case false:
              navigationService.clearStackAndShow(Routes.donorFormView);
              notifyListeners();
              break;
            default:
              notifyListeners();
          }
        }
      });

      if (result.hasError) {
        navigationService.popRepeated(1);
        switch (result.exceptionCode) {
          case 'user-not-found':
            signInError = 'Oops! We have no record of this user';
            notifyListeners();
            break;
          case 'wrong-password':
            signInError = "Urm, wrong email or password";
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
