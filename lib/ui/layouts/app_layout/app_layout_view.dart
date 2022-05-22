import 'package:animations/animations.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view.dart';
import 'package:blood_source/ui/views/donate/donate_view.dart';
import 'package:blood_source/ui/views/notifications/notifications_view.dart';
import 'package:blood_source/ui/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './app_layout_view_model.dart';

class AppLayoutView extends StatelessWidget {
  const AppLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getView(int index) {
      switch (index) {
        case 0:
          return const DashboardView();
        case 1:
          return const DonateView();
        case 2:
          return const NotificationsView();
        case 3:
          return const ProfileView();
        default:
          return const DashboardView();
      }
    }

    return ViewModelBuilder<AppLayoutViewModel>.reactive(
      viewModelBuilder: () => AppLayoutViewModel(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: model.reverse,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
              );
            },
            child: getView(model.currentIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: const [
              BottomNavigationBarItem(
                label: 'Dashboard',
                icon: Icon(Icons.dashboard),
              ),
              BottomNavigationBarItem(
                label: 'Donate',
                icon: Icon(Icons.health_and_safety),
              ),
              BottomNavigationBarItem(
                label: 'Notifications',
                icon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        );
      },
    );
  }
}
