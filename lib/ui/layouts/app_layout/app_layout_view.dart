import 'package:animations/animations.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/app_icons.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './app_layout_view_model.dart';

class AppLayoutView extends StatelessWidget {
  const AppLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppLayoutViewModel>.reactive(
      viewModelBuilder: () => AppLayoutViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

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
            child: model.getView(model.currentIndex),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.h),
            ),
            backgroundColor: AppColors.primary,
            onPressed: model.goToMakeRequestView,
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
