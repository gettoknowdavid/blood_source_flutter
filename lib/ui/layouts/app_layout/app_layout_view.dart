import 'package:animations/animations.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/app_icons.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view.dart';
import 'package:blood_source/ui/views/donate/donate_view.dart';
import 'package:blood_source/ui/views/notifications/notifications_view.dart';
import 'package:blood_source/ui/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 100.w,
            leading: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 42.h,
                        width: 42.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.swatch.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.pin_drop_outlined,
                          size: 26.sp,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        'PHC',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: PageTransitionSwitcher(
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
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.h),
            ),
            backgroundColor: AppColors.primary,
            onPressed: () {},
            child: ImageIcon(
              const AssetImage('assets/images/blood.png'),
              size: 20.sp,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 20.sp,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: AppIcons.home,
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: AppIcons.profile,
              ),
              BottomNavigationBarItem(
                label: 'Notifications',
                icon: AppIcons.bell,
              ),
              BottomNavigationBarItem(
                label: 'Settings',
                icon: AppIcons.settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
