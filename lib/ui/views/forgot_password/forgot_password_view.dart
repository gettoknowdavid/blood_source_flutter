import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/layouts/auth_layout.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/ui/shared/widgets/auth_layout_header.dart';
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
        return AuthLayout(
          showBackButton: true,
          child: Form(
            key: model.forgotPasswordForm,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthLayoutHeader(
                    title: 'Forgot Password?',
                    subtitle:
                        "Don't worry! It happens. \nWe just need the address linked with your account.",
                  ),
                  20.verticalSpace,
                  Image.asset(ImageResources.forgotPassword),
                  20.verticalSpace,
                  AppTextField(
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter email',
                    onChanged: (value) => model.onChanged(value),
                    textInputAction: TextInputAction.done,
                  ),
                  20.verticalSpace,
                  model.signInError == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            Text(
                              model.signInError!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                            20.verticalSpace,
                          ],
                        ),
                  AppButton(
                    onTap:
                        model.isFormValidated() ? () => model.submit() : null,
                    text: 'Submit',
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
