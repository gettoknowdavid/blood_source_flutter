import 'package:blood_source/ui/views/check_email/check_email_view.dart';
import 'package:blood_source/ui/views/check_email/check_email_view_model.dart';
import 'package:blood_source/ui/views/forgot_password/forgot_password_view.dart';
import 'package:blood_source/ui/views/forgot_password/forgot_password_view_model.dart';
import 'package:blood_source/ui/views/home/home_view.dart';
import 'package:blood_source/ui/views/home/home_view_model.dart';
import 'package:blood_source/ui/views/sign_in/sign_in_view.dart';
import 'package:blood_source/ui/views/sign_in/sign_in_view_model.dart';
import 'package:blood_source/ui/views/sign_up/sign_up_view.dart';
import 'package:blood_source/ui/views/sign_up/sign_up_view_model.dart';
import 'package:blood_source/ui/views/splash/splash_view.dart';
import 'package:blood_source/ui/views/splash/splash_view_model.dart';
import 'package:blood_source/ui/views/verify_email/verify_email_view.dart';
import 'package:blood_source/ui/views/verify_email/verify_email_view_model.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: CheckEmailView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: VerifyEmailView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: SplashViewModel),
    LazySingleton(classType: SignInViewModel),
    LazySingleton(classType: ForgotPasswordViewModel),
    LazySingleton(classType: CheckEmailViewModel),
    LazySingleton(classType: SignUpViewModel),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: VerifyEmailViewModel),
  ],
)
class App {}
