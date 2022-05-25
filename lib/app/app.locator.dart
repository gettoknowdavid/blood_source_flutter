// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';
import '../services/mail_app_service.dart';
import '../services/storage_service.dart';
import '../services/store_service.dart';
import '../ui/layouts/app_layout/app_layout_view_model.dart';
import '../ui/views/check_email/check_email_view_model.dart';
import '../ui/views/dashboard/dashboard_view_model.dart';
import '../ui/views/donate/donate_view_model.dart';
import '../ui/views/donor/donor_view_model.dart';
import '../ui/views/donor_form/donor_form_view_model.dart';
import '../ui/views/edit_profile/edit_profile_view_model.dart';
import '../ui/views/forgot_password/forgot_password_view_model.dart';
import '../ui/views/home/home_view_model.dart';
import '../ui/views/main_scaffold/main_scaffold_view_model.dart';
import '../ui/views/notifications/notifications_view_model.dart';
import '../ui/views/profile/profile_view_model.dart';
import '../ui/views/sign_in/sign_in_view_model.dart';
import '../ui/views/sign_up/sign_up_view_model.dart';
import '../ui/views/splash/splash_view_model.dart';
import '../ui/views/verify_email/verify_email_view_model.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => MailAppService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => StoreService());
  locator.registerLazySingleton(() => FirebaseAuthenticationService());
  locator.registerLazySingleton(() => SplashViewModel());
  locator.registerLazySingleton(() => MainScaffoldViewModel());
  locator.registerLazySingleton(() => SignInViewModel());
  locator.registerLazySingleton(() => ForgotPasswordViewModel());
  locator.registerLazySingleton(() => CheckEmailViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => DonorFormViewModel());
  locator.registerLazySingleton(() => VerifyEmailViewModel());
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => AppLayoutViewModel());
  locator.registerLazySingleton(() => DonateViewModel());
  locator.registerLazySingleton(() => NotificationsViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => DonorViewModel());
  locator.registerLazySingleton(() => EditProfileViewModel());
}
