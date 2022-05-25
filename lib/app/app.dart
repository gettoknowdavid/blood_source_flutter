import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/services/mail_app_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/layouts/app_layout/app_layout_view.dart';
import 'package:blood_source/ui/layouts/app_layout/app_layout_view_model.dart';
import 'package:blood_source/ui/views/check_email/check_email_view.dart';
import 'package:blood_source/ui/views/check_email/check_email_view_model.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view_model.dart';
import 'package:blood_source/ui/views/donate/donate_view.dart';
import 'package:blood_source/ui/views/donate/donate_view_model.dart';
import 'package:blood_source/ui/views/donor/donor_view.dart';
import 'package:blood_source/ui/views/donor/donor_view_model.dart';
import 'package:blood_source/ui/views/donor_form/donor_form_view.dart';
import 'package:blood_source/ui/views/donor_form/donor_form_view_model.dart';
import 'package:blood_source/ui/views/forgot_password/forgot_password_view.dart';
import 'package:blood_source/ui/views/forgot_password/forgot_password_view_model.dart';
import 'package:blood_source/ui/views/home/home_view.dart';
import 'package:blood_source/ui/views/home/home_view_model.dart';
import 'package:blood_source/ui/views/main_scaffold/main_scaffold_view.dart';
import 'package:blood_source/ui/views/main_scaffold/main_scaffold_view_model.dart';
import 'package:blood_source/ui/views/notifications/notifications_view.dart';
import 'package:blood_source/ui/views/notifications/notifications_view_model.dart';
import 'package:blood_source/ui/views/profile/profile_view.dart';
import 'package:blood_source/ui/views/profile/profile_view_model.dart';
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
    MaterialRoute(page: MainScaffoldView),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: CheckEmailView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: DonorFormView),
    MaterialRoute(page: VerifyEmailView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: AppLayoutView),
    MaterialRoute(page: DonateView),
    MaterialRoute(page: NotificationsView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: DonorView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: MailAppService),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: StoreService),
    LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: SplashViewModel),
    LazySingleton(classType: MainScaffoldViewModel),
    LazySingleton(classType: SignInViewModel),
    LazySingleton(classType: ForgotPasswordViewModel),
    LazySingleton(classType: CheckEmailViewModel),
    LazySingleton(classType: SignUpViewModel),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: DonorFormViewModel),
    LazySingleton(classType: VerifyEmailViewModel),
    LazySingleton(classType: DashboardViewModel),
    LazySingleton(classType: AppLayoutViewModel),
    LazySingleton(classType: DonateViewModel),
    LazySingleton(classType: NotificationsViewModel),
    LazySingleton(classType: ProfileViewModel),
    LazySingleton(classType: DonorViewModel),
  ],
)
class App {}
