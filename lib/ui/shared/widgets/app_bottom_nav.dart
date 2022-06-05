import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/bottom_nav_item.dart';
import 'package:blood_source/ui/layouts/app_layout/app_layout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomNav extends ViewModelWidget<AppLayoutViewModel> {
  const AppBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AppLayoutViewModel viewModel) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: viewModel.currentIndex,
      onTap: viewModel.setIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      items: navItems.map((BottomNavItem item) {
        return BottomNavigationBarItem(
          backgroundColor: Colors.grey[100],
          label: item.title,
          icon: navItems.indexOf(item) != 2
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(item.icon, size: 28.sp),
                    navItems.indexOf(item) == 3
                        ? Positioned(
                            right: -8.w,
                            top: -8.h,
                            child: Container(
                              height: 18.w,
                              width: 18.w,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                viewModel.eventsCount.toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                )
              : Container(
                  child: Icon(item.icon, color: Colors.white),
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 3,
                        color: AppColors.swatch.shade100,
                        offset: Offset(0.w, 4.h),
                        blurRadius: 6,
                      )
                    ],
                  ),
                ),
        );
      }).toList(),
    );
  }
}
