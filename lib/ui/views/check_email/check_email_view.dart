import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/layouts/auth_layout.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/auth_layout_header.dart';
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
        return AuthLayout(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const AuthLayoutHeader(
                title: 'Check your mail',
                subtitle:
                    'We have sent password recovery instructions to your mail.',
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 0.sp,
                      color: Colors.black54,
                    ),
                  ),
                  AppTextButton(
                    text: 'try another email address',
                    onTap: () {},
                    fontSize: 14.sp,
                    color: AppColors.swatch.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              30.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
