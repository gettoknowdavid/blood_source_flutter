import 'package:blood_source/common/app_colors.dart';
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                50.verticalSpace,
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16).r,
                  child: Text('Hi ${model.firstName}!'),
                ),
                30.verticalSpace,
                Text(
                  'GIVE THE GIFT OF LIFE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Donate Blood',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.swatch.shade700,
                  ),
                ),
                4.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                  child: Text(
                    'Your donation can save a life today.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.sp, color: Colors.black87),
                  ),
                ),
                20.verticalSpace,
                if (model.isBusy)
                  const Center(child: CircularProgressIndicator())
                else
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.r,
                      vertical: 30.r,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.h,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount: model.buttonList.length,
                    itemBuilder: (BuildContext context, i) {
                      return DashboardButtonItem(
                        model: model.buttonList[i],
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
