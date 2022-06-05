import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DashboardButtonModel {
  final String title;
  final Widget icon;
  final Color backgroundColor;
  final String route;

  DashboardButtonModel(
    this.title,
    this.icon,
    this.backgroundColor,
    this.route,
  );
}

final List<DashboardButtonModel> donorButtonList = <DashboardButtonModel>[
  DashboardButtonModel(
    'Find Requests',
    const Icon(PhosphorIcons.magnifyingGlass, color: AppColors.primary),
    const Color(0xFFFA6393),
    Routes.requestListView,
  ),
  DashboardButtonModel(
    'My Requests',
    const Icon(PhosphorIcons.bellSimple, color: AppColors.primary),
    const Color(0xFFFA6393),
    Routes.myRequestsListView,
  ),
  DashboardButtonModel(
    'Hospitals',
    const Icon(PhosphorIcons.firstAid, color: Color(0xFF00CC99)),
    const Color(0xFF00CC99),
    Routes.donateView,
  ),
  DashboardButtonModel(
    'Others',
    const Icon(PhosphorIcons.gearSix, color: Color(0xFF616161)),
    const Color(0xFF999999),
    Routes.donateView,
  ),
];

final List<DashboardButtonModel> recipientButtonList = <DashboardButtonModel>[
  DashboardButtonModel(
    'Find a Donor',
    const Icon(PhosphorIcons.magnifyingGlass, color: AppColors.primary),
    const Color(0xFFFA6393),
    Routes.donorView,
  ),
  DashboardButtonModel(
    'My Requests',
    const Icon(PhosphorIcons.bellSimple, color: AppColors.primary),
    const Color(0xFFFA6393),
    Routes.myRequestsListView,
  ),
  DashboardButtonModel(
    'Hospitals',
    const Icon(PhosphorIcons.firstAid, color: Color(0xFF00CC99)),
    const Color(0xFF00CC99),
    Routes.donateView,
  ),
  DashboardButtonModel(
    'Others',
    const Icon(PhosphorIcons.gearSix, color: Color(0xFF616161)),
    const Color(0xFF999999),
    Routes.donateView,
  ),
];
