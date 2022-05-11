import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/utils/dialog_type.dart';
import 'package:blood_source/utils/password_rules.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel with ReactiveServiceMixin {
  SignUpViewModel() {
    listenToReactiveValues([_rules, _rulesVisibility, _ruleColor]);
  }

  void initialise() {
    notifyListeners();
  }

  Future<void> init() async {}

  DialogService dialogService = locator<DialogService>();
  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuthenticationService authService =
      locator<FirebaseAuthenticationService>();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;

  bool _isPasswordObscure = false;
  bool get isPasswordObscure => _isPasswordObscure;

  String? signUpError;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ReactiveValue<List<Map>> _rules =
      ReactiveValue<List<Map>>(passwordRules);
  final ReactiveValue<bool> _rulesVisibility = ReactiveValue<bool>(false);
  final ReactiveValue<Color> _ruleColor =
      ReactiveValue<Color>(AppColors.swatch.shade900);

  List<Map> get rules => _rules.value;
  bool get rulesVisibility => _rulesVisibility.value;
  Color get ruleColor => _ruleColor.value;

  void toggleObscurity() {
    _isPasswordObscure = !_isPasswordObscure;
    notifyListeners();
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

      if (result.user != null) {
        navigationService.popRepeated(1);
        navigationService.clearStackAndShow(Routes.verifyEmailView);
        notifyListeners();
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
