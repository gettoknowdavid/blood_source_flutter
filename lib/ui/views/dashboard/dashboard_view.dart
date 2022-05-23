import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/dashboard_item.dart';
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
        return SingleChildScrollView(
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
                    return Container(
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
                            child: buttonList[i].icon,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: buttonList[i]
                                  .backgroundColor
                                  .withOpacity(0.2),
                            ),
                          ),
                          12.verticalSpace,
                          Text(
                            buttonList[i].title,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          15.verticalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.r),
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              buttonList[i].subtitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
