import 'package:blood_source/ui/layouts/auth_layout.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/ui/shared/widgets/auth_layout_header.dart';
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
        return AuthLayout(
          showBackButton: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AuthLayoutHeader(
                  title: 'Sign Up',
                  subtitle: "We welcome you to Blood Source",
                ),
                40.verticalSpace,
                AppTextField(
                  controller: model.nameController,
                  hintText: 'Name',
                ),
                20.verticalSpace,
                AppTextField(
                  controller: model.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                20.verticalSpace,
                AppTextField(
                  controller: model.passwordController,
                  hintText: 'Password',
                  isPassword: true,
                ),
                40.verticalSpace,
                AppButton(
                  onTap: model.isFormValidated()
                      ? () async => await model.signUp()
                      : null,
                  text: 'Sign Up',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
