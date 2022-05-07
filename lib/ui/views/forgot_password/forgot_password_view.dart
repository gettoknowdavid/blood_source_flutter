import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.03),
                  ),
                  child: CustomPaint(
                    painter: HeaderPainter(),
                    child: Form(
                      key: model.forgotPasswordForm,
                      child: Center(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.symmetric(horizontal: 24.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Forgot Password?',
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
                                  "Don't worry! It happens.\n Please enter the email address associated with your account.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              40.verticalSpace,
                              Image.asset(ImageResources.forgotPassword),
                              40.verticalSpace,
                              AppTextField(
                                controller: model.emailController,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Enter email',
                                // onChanged: (value) => model.onChanged(value),
                                textInputAction: TextInputAction.done,
                              ),
                              18.verticalSpace,
                              AppButton(
                                onTap: model.isFormValidated()
                                    ? () => model.submit()
                                    : null,
                                text: 'Submit',
                              ),
                              30.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const AppBackButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
