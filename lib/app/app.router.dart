// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/blood_source_user.dart';
import '../models/request.dart';
import '../ui/layouts/app_layout/app_layout_view.dart';
import '../ui/views/check_email/check_email_view.dart';
import '../ui/views/dashboard/dashboard_view.dart';
import '../ui/views/donate/donate_view.dart';
import '../ui/views/donor/donor_view.dart';
import '../ui/views/donor_details/donor_details_view.dart';
import '../ui/views/donor_form/donor_form_view.dart';
import '../ui/views/edit_profile/edit_profile_view.dart';
import '../ui/views/events/events_view.dart';
import '../ui/views/forgot_password/forgot_password_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/main_scaffold/main_scaffold_view.dart';
import '../ui/views/my_requests_list/my_requests_list_view.dart';
import '../ui/views/notifications/notifications_view.dart';
import '../ui/views/profile/profile_view.dart';
import '../ui/views/request/request_view.dart';
import '../ui/views/request_details/request_details_view.dart';
import '../ui/views/request_list/request_list_view.dart';
import '../ui/views/sign_in/sign_in_view.dart';
import '../ui/views/sign_up/sign_up_view.dart';
import '../ui/views/splash/splash_view.dart';
import '../ui/views/verify_email/verify_email_view.dart';

class Routes {
  static const String splashView = '/';
  static const String mainScaffoldView = '/main-scaffold-view';
  static const String signInView = '/sign-in-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String checkEmailView = '/check-email-view';
  static const String signUpView = '/sign-up-view';
  static const String homeView = '/home-view';
  static const String donorFormView = '/donor-form-view';
  static const String verifyEmailView = '/verify-email-view';
  static const String dashboardView = '/dashboard-view';
  static const String appLayoutView = '/app-layout-view';
  static const String donateView = '/donate-view';
  static const String notificationsView = '/notifications-view';
  static const String profileView = '/profile-view';
  static const String donorView = '/donor-view';
  static const String requestView = '/request-view';
  static const String editProfileView = '/edit-profile-view';
  static const String requestListView = '/request-list-view';
  static const String myRequestsListView = '/my-requests-list-view';
  static const String requestDetailsView = '/request-details-view';
  static const String donorDetailsView = '/donor-details-view';
  static const String eventsView = '/events-view';
  static const all = <String>{
    splashView,
    mainScaffoldView,
    signInView,
    forgotPasswordView,
    checkEmailView,
    signUpView,
    homeView,
    donorFormView,
    verifyEmailView,
    dashboardView,
    appLayoutView,
    donateView,
    notificationsView,
    profileView,
    donorView,
    requestView,
    editProfileView,
    requestListView,
    myRequestsListView,
    requestDetailsView,
    donorDetailsView,
    eventsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.mainScaffoldView, page: MainScaffoldView),
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
    RouteDef(Routes.checkEmailView, page: CheckEmailView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.donorFormView, page: DonorFormView),
    RouteDef(Routes.verifyEmailView, page: VerifyEmailView),
    RouteDef(Routes.dashboardView, page: DashboardView),
    RouteDef(Routes.appLayoutView, page: AppLayoutView),
    RouteDef(Routes.donateView, page: DonateView),
    RouteDef(Routes.notificationsView, page: NotificationsView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.donorView, page: DonorView),
    RouteDef(Routes.requestView, page: RequestView),
    RouteDef(Routes.editProfileView, page: EditProfileView),
    RouteDef(Routes.requestListView, page: RequestListView),
    RouteDef(Routes.myRequestsListView, page: MyRequestsListView),
    RouteDef(Routes.requestDetailsView, page: RequestDetailsView),
    RouteDef(Routes.donorDetailsView, page: DonorDetailsView),
    RouteDef(Routes.eventsView, page: EventsView),
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
    MainScaffoldView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MainScaffoldView(),
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
    CheckEmailView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CheckEmailView(),
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
    DonorFormView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DonorFormView(),
        settings: data,
      );
    },
    VerifyEmailView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const VerifyEmailView(),
        settings: data,
      );
    },
    DashboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DashboardView(),
        settings: data,
      );
    },
    AppLayoutView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AppLayoutView(),
        settings: data,
      );
    },
    DonateView: (data) {
      var args = data.getArgs<DonateViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DonateView(
          key: args.key,
          donor: args.donor,
        ),
        settings: data,
      );
    },
    NotificationsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NotificationsView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      var args = data.getArgs<ProfileViewArguments>(
        orElse: () => ProfileViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(
          key: args.key,
          user: args.user,
          isFromRoute: args.isFromRoute,
        ),
        settings: data,
      );
    },
    DonorView: (data) {
      var args = data.getArgs<DonorViewArguments>(
        orElse: () => DonorViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DonorView(
          key: args.key,
          fromRequestView: args.fromRequestView,
          request: args.request,
        ),
        settings: data,
      );
    },
    RequestView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RequestView(),
        settings: data,
      );
    },
    EditProfileView: (data) {
      var args = data.getArgs<EditProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileView(
          key: args.key,
          user: args.user,
          isFirstEdit: args.isFirstEdit,
        ),
        settings: data,
      );
    },
    RequestListView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RequestListView(),
        settings: data,
      );
    },
    MyRequestsListView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MyRequestsListView(),
        settings: data,
      );
    },
    RequestDetailsView: (data) {
      var args = data.getArgs<RequestDetailsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RequestDetailsView(
          key: args.key,
          request: args.request,
        ),
        settings: data,
      );
    },
    DonorDetailsView: (data) {
      var args = data.getArgs<DonorDetailsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DonorDetailsView(
          key: args.key,
          donor: args.donor,
        ),
        settings: data,
      );
    },
    EventsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const EventsView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DonateView arguments holder class
class DonateViewArguments {
  final Key? key;
  final BloodSourceUser donor;
  DonateViewArguments({this.key, required this.donor});
}

/// ProfileView arguments holder class
class ProfileViewArguments {
  final Key? key;
  final BloodSourceUser? user;
  final bool isFromRoute;
  ProfileViewArguments({this.key, this.user, this.isFromRoute = false});
}

/// DonorView arguments holder class
class DonorViewArguments {
  final Key? key;
  final bool fromRequestView;
  final Request? request;
  DonorViewArguments({this.key, this.fromRequestView = false, this.request});
}

/// EditProfileView arguments holder class
class EditProfileViewArguments {
  final Key? key;
  final BloodSourceUser user;
  final bool isFirstEdit;
  EditProfileViewArguments(
      {this.key, required this.user, this.isFirstEdit = false});
}

/// RequestDetailsView arguments holder class
class RequestDetailsViewArguments {
  final Key? key;
  final Request request;
  RequestDetailsViewArguments({this.key, required this.request});
}

/// DonorDetailsView arguments holder class
class DonorDetailsViewArguments {
  final Key? key;
  final BloodSourceUser donor;
  DonorDetailsViewArguments({this.key, required this.donor});
}
