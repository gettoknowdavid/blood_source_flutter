import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './check_email_view_model.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckEmailViewModel>.reactive(
      viewModelBuilder: () => CheckEmailViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.03),
              ),
              child: CustomPaint(
                painter: HeaderPainter(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        Text(
                          'Check your mail',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        4.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.r),
                          child: Text(
                            "We have sent password recovery instructions to your mail.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        30.verticalSpace,
                        Image.asset(ImageResources.checkEmail),
                        40.verticalSpace,
                        AppButton(
                          onTap: () => model.openMailApp(),
                          text: 'Open email app',
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No mail yet? Check your spam filter, or',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                height: 0.sp,
                                color: Colors.black54,
                              ),
                            ),
                            AppTextButton(
                              text: 'try another email address',
                              onTap: () {},
                              fontSize: 17.sp,
                              color: AppColors.swatch.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        30.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
