import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/dashboard_button_model.dart';
import 'package:blood_source/ui/views/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardButtonItem extends ViewModelWidget<DashboardViewModel> {
  const DashboardButtonItem({Key? key, required this.model}) : super(key: key);

  final DashboardButtonModel model;

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    final NavigationService _navService = locator<NavigationService>();

    return GestureDetector(
      onTap: model.route == Routes.donorView
          ? () => viewModel.goToDonors()
          : () => _navService.navigateTo(model.route),
      child: Container(
        alignment: Alignment.center,
        height: 0.5 * 1.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 10,
              color: Colors.black.withOpacity(0.01),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(24.r),
              child: model.icon,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.backgroundColor.withOpacity(0.2),
              ),
            ),
            12.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.r),
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            15.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.r),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                model.subtitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
