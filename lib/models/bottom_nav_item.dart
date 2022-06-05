import 'package:flutter/cupertino.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavItem {
  final String title;
  final IconData icon;

  BottomNavItem({required this.title, required this.icon});
}

List<BottomNavItem> navItems = [
  BottomNavItem(title: 'Home', icon: PhosphorIcons.houseSimpleBold),
  BottomNavItem(title: 'Profile', icon: PhosphorIcons.userBold),
  BottomNavItem(title: 'Make Request', icon: PhosphorIcons.dropBold),
  BottomNavItem(title: 'Events', icon: PhosphorIcons.calendarBold),
  BottomNavItem(title: 'Settings', icon: PhosphorIcons.gearSixBold),
];
