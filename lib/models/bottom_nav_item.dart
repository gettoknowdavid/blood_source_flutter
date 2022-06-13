import 'package:flutter/cupertino.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavItem {
  final String title;
  final IconData icon;

  BottomNavItem({required this.title, required this.icon});
}

List<BottomNavItem> navItems = [
  BottomNavItem(title: 'Home', icon: PhosphorIcons.houseSimple),
  BottomNavItem(title: 'Profile', icon: PhosphorIcons.user),
  BottomNavItem(title: 'Make Request', icon: PhosphorIcons.drop),
  BottomNavItem(title: 'Events', icon: PhosphorIcons.calendar),
  BottomNavItem(title: 'About', icon: PhosphorIcons.info),
];
