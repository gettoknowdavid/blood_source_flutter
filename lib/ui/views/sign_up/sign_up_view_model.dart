import 'dart:developer';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/custom_user.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:blood_source/utils/password_rules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel with ReactiveServiceMixin {
  SignUpViewModel() {
    listenToReactiveValues([_rules, _rulesVisibility, _ruleColor, _userType]);
  }

  Future<void> init() async {}

  DialogService dialogService = locator<DialogService>();
  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;

  String? signUpError;

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

  List<Map> get rules => _rules.value;
  bool get rulesVisibility => _rulesVisibility.value;
  Color get ruleColor => _ruleColor.value;
  UserType get userType => _userType.value;

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
      dialogService.showCustomDialog(variant: DialogType.loading);

      final FirebaseAuthenticationResult result =
          await authService.createAccountWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result.hasError) {
        navigationService.popRepeated(1);
        signUpError = result.errorMessage;
      }

      final _donorCustomUser = CustomUser(
        userType: _userType.value,
        isDonorFormComplete: false,
      );

      final _recipientCustomUser = CustomUser(userType: _userType.value);

      if (result.user != null) {
        final collection = FirebaseFirestore.instance.collection;
        final doc = collection('users').doc(result.user!.uid);

        switch (_userType.value) {
          case UserType.donor:
            await doc.set(_donorCustomUser.toFirestore());
            navigationService.clearStackAndShow(Routes.verifyEmailView);
            notifyListeners();
            break;
          case UserType.recipient:
            await doc.set(_recipientCustomUser.toFirestore());
            navigationService.clearStackAndShow(Routes.verifyEmailView);
            notifyListeners();
            break;
          default:
            null;
        }
      }

      authService.authStateChanges.listen((User? user) {
        if (user != null) {
          user.updateDisplayName(nameController.text.trim());
        }
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
