import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/dashboard_button_model.dart';
import 'package:blood_source/ui/shared/widgets/dashboard/dashboard_button_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) async => await model.init(),
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                30.verticalSpace,
                Text(
                  'GIVE THE GIFT OF LIFE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Donate Blood',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.swatch.shade700,
                  ),
                ),
                20.verticalSpace,
                Text(
                  'Each donation can help save up to 3 lives!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                ),
                10.verticalSpace,
                SizedBox(
                  height: 0.6 * 1.sh,
                  child: GridView.builder(
                    primary: false,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 30.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 11,
                      crossAxisSpacing: 20.h,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount: buttonList.length,
                    itemBuilder: (BuildContext context, i) {
                      return DashboardButtonItem(model: buttonList[i]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
