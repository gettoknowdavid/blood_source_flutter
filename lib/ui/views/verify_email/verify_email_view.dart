import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>.reactive(
      viewModelBuilder: () => VerifyEmailViewModel(),
      onModelReady: (VerifyEmailViewModel model) async {
        await model.init();
      },
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: AppColors.primary.withOpacity(0.03),
              child: CustomPaint(
                painter: HeaderPainter(),
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Email Verification',
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
                            "A verification email has been sent to your email, please verify your account.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        40.verticalSpace,
                        Image.asset(ImageResources.verifyEmail),
                        30.verticalSpace,
                        Text(
                          model.isVerified ? 'Verified' : 'Not Verified',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: model.isVerified
                                ? Colors.green
                                : Colors.black54,
                          ),
                        ),
                        6.verticalSpace,
                        AppTextButton(
                          onTap: () {},
                          text: 'Resend Email',
                          fontSize: 19.sp,
                          color: AppColors.swatch.shade900,
                          fontWeight: FontWeight.w600,
                        )
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
