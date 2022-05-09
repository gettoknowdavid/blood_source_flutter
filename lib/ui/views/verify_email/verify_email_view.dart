import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/layouts/auth_layout.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/auth_layout_header.dart';
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
        return AuthLayout(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AuthLayoutHeader(
                  title: 'Email Verification',
                  subtitle:
                      "A verification email has been sent to your email, please verify your account.",
                ),
                20.verticalSpace,
                Image.asset(ImageResources.verifyEmail),
                30.verticalSpace,
                Text(
                  model.isVerified ? 'Verified' : 'Not Verified',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: model.isVerified ? Colors.green : Colors.black54,
                  ),
                ),
                6.verticalSpace,
                AppTextButton(
                  onTap: () {},
                  text: 'Resend Email',
                  fontSize: 14.sp,
                  color: AppColors.swatch.shade900,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
