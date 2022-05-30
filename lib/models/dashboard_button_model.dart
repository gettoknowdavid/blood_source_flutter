import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardButtonModel {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color backgroundColor;
  final String route;

  DashboardButtonModel(
    this.title,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.route,
  );
}

final List<DashboardButtonModel> donorButtonList = <DashboardButtonModel>[
  DashboardButtonModel(
    'Find Requests',
    '22k',
    const Icon(Icons.search, color: AppColors.primary),
    const Color(0xFFFA6393),
    Routes.requestListView,
  ),
  DashboardButtonModel(
    'My Requests',
    '32k',
    const ImageIcon(
      AssetImage('assets/images/bell.png'),
      color: AppColors.primary,
    ),
    const Color(0xFFFA6393),
    Routes.myRequestsListView,
  ),
  DashboardButtonModel(
    'Blood Bank',
    'Map',
    const ImageIcon(
      AssetImage('assets/images/blood.png'),
      color: Color(0xFF00CC99),
    ),
    const Color(0xFF00CC99),
    Routes.donateView,
  ),
  DashboardButtonModel(
    'Others',
    'More',
    const ImageIcon(
      AssetImage('assets/images/settings.png'),
      color: Color(0xFF999999),
    ),
    const Color(0xFF999999),
    Routes.donateView,
  ),
];

final List<DashboardButtonModel> recipientButtonList = <DashboardButtonModel>[
  DashboardButtonModel(
    'Find a Donor',
    '22k',
    const Icon(Icons.search, color: AppColors.primary),
    const Color(0xFFFA6393),
    Routes.donorView,
  ),
  DashboardButtonModel(
    'Request Blood',
    '32k',
    const ImageIcon(
      AssetImage('assets/images/bell.png'),
      color: AppColors.primary,
    ),
    const Color(0xFFFA6393),
    Routes.donateView,
  ),
  DashboardButtonModel(
    'Blood Bank',
    'Map',
    const ImageIcon(
      AssetImage('assets/images/blood.png'),
      color: Color(0xFF00CC99),
    ),
    const Color(0xFF00CC99),
    Routes.donateView,
  ),
  DashboardButtonModel(
    'Others',
    'More',
    const ImageIcon(
      AssetImage('assets/images/settings.png'),
      color: Color(0xFF999999),
    ),
    const Color(0xFF999999),
    Routes.donateView,
  ),
];
