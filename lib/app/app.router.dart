// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/forgot_password/forgot_password_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/sign_in/sign_in_view.dart';
import '../ui/views/sign_up/sign_up_view.dart';
import '../ui/views/splash/splash_view.dart';
import '../ui/views/verify_email/verify_email_view.dart';

class Routes {
  static const String splashView = '/';
  static const String signInView = '/sign-in-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String signUpView = '/sign-up-view';
  static const String homeView = '/home-view';
  static const String verifyEmailView = '/verify-email-view';
  static const all = <String>{
    splashView,
    signInView,
    forgotPasswordView,
    signUpView,
    homeView,
    verifyEmailView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.verifyEmailView, page: VerifyEmailView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashView(),
        settings: data,
      );
    },
    SignInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignInView(),
        settings: data,
      );
    },
    ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ForgotPasswordView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    VerifyEmailView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const VerifyEmailView(),
        settings: data,
      );
    },
  };
}
