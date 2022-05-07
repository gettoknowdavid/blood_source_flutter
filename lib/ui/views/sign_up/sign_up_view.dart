import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onModelReady: (SignUpViewModel model) async {
        await model.init();
      },
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
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
                              'Sign Up',
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
                                "Welcome to BloodSource",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            40.verticalSpace,
                            AppTextField(
                              controller: model.nameController,
                              hintText: 'Name',
                            ),
                            18.verticalSpace,
                            AppTextField(
                              controller: model.emailController,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            18.verticalSpace,
                            AppTextField(
                              controller: model.passwordController,
                              hintText: 'Password',
                              isPassword: true,
                            ),
                            40.verticalSpace,
                            AppButton(
                              onTap: () => model.signUp(),
                              text: 'Sign Up',
                            ),
                          ],
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
