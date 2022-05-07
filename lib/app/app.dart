import 'package:blood_source/ui/views/home/home_view.dart';
import 'package:blood_source/ui/views/home/home_view_model.dart';
import 'package:blood_source/ui/views/sign_in/sign_in_view.dart';
import 'package:blood_source/ui/views/sign_in/sign_in_view_model.dart';
import 'package:blood_source/ui/views/splash/splash_view.dart';
import 'package:blood_source/ui/views/splash/splash_view_model.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FirebaseAuthenticationService),
    LazySingleton(classType: SplashViewModel),
    LazySingleton(classType: SignInViewModel),
    LazySingleton(classType: HomeViewModel),
  ],
)
class App {}
