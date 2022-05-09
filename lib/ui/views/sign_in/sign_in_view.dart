import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/layouts/auth_layout.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/ui/shared/widgets/auth_layout_header.dart';
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
        return AuthLayout(
          child: Form(
            key: model.signInFormKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthLayoutHeader(
                    title: 'Hello Again!',
                    subtitle: "Welcome back, you've \nbeen missed",
                  ),
                  30.verticalSpace,
                  AppTextField(
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter email',
                    onChanged: (value) => model.onChanged(value),
                    textInputAction: TextInputAction.next,
                  ),
                  20.verticalSpace,
                  AppTextField(
                    controller: model.passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    onChanged: (value) => model.onChanged(value),
                    textInputAction: TextInputAction.done,
                  ),
                  5.verticalSpace,
                  AppTextButton(
                    text: 'Password Recovery',
                    onTap: () => model.goToForgotPassword(),
                    color: Colors.black54,
                    alignment: Alignment.centerRight,
                  ),
                  30.verticalSpace,
                  model.signInError == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            Text(
                              model.signInError!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                            20.verticalSpace,
                          ],
                        ),
                  AppButton(
                    onTap: model.isFormValidated()
                        ? () async => await model.signIn()
                        : null,
                    text: 'Sign In',
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      6.horizontalSpace,
                      AppTextButton(
                        text: 'Register now',
                        onTap: () => model.goToSignUp(),
                        fontSize: 14.sp,
                        color: AppColors.swatch.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
