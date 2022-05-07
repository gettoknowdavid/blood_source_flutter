import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      onModelReady: (SignInViewModel model) async {
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
                          'Hello Again!',
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
                            "Welcome back, you've been missed!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        40.verticalSpace,
                        AppTextField(
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter email',
                        ),
                        18.verticalSpace,
                        AppTextField(
                          controller: model.passwordController,
                          hintText: 'Password',
                          isPassword: true,
                        ),
                        AppTextButton(
                          text: 'Password Recovery',
                          onTap: () {},
                          fontSize: 16.sp,
                          color: Colors.black54,
                          alignment: Alignment.centerRight,
                        ),
                        40.verticalSpace,
                        AppButton(onTap: () => model.signIn(), text: 'Sign In'),
                        30.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            6.horizontalSpace,
                            AppTextButton(
                              text: 'Register now',
                              onTap: () => model.navigationService!.navigateTo(
                                Routes.verifyEmailView,
                              ),
                              fontSize: 17.sp,
                              color: AppColors.swatch.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
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
