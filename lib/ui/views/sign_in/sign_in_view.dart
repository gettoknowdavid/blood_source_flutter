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
                child: Form(
                  key: model.signInFormKey,
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
                            onChanged: (value) => model.onChanged(value),
                            textInputAction: TextInputAction.next,
                          ),
                          18.verticalSpace,
                          AppTextField(
                            controller: model.passwordController,
                            hintText: 'Password',
                            isPassword: true,
                            onChanged: (value) => model.onChanged(value),
                            textInputAction: TextInputAction.done,
                          ),
                          AppTextButton(
                            text: 'Password Recovery',
                            onTap: () => model.goToForgotPassword(),
                            fontSize: 16.sp,
                            color: Colors.black54,
                            alignment: Alignment.centerRight,
                          ),
                          10.verticalSpace,
                          model.signInError == null
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    Text(
                                      model.signInError!,
                                      style: TextStyle(
                                        fontSize: 14.5.sp,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                    30.verticalSpace,
                                  ],
                                ),
                          AppButton(
                            onTap: model.isFormValidated()
                                ? () async => await model.signIn()
                                : null,
                            text: 'Sign In',
                          ),
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
                                onTap: () => model.goToSignUp(),
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
          ),
        );
      },
    );
  }
}
