import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/ui/layouts/auth_layout.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/ui/shared/widgets/auth_layout_header.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:blood_source/ui/shared/widgets/sign_up/password_rules_widget.dart';
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
      onModelReady: (model) async => await model.init(),
      createNewModelOnInsert: true,
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        return AuthLayout(
          showBackButton: true,
          child: SingleChildScrollView(
            child: !model.isConnected!
                ? OfflineWidget(onTap: model.checkConnectivity)
                : Form(
                    key: model.signUpFormKey,
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
                          onChanged: (value) => model.onChanged(value),
                          textInputAction: TextInputAction.next,
                        ),
                        20.verticalSpace,
                        AppTextField(
                          controller: model.emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => model.onChanged(value),
                          textInputAction: TextInputAction.next,
                        ),
                        20.verticalSpace,
                        AppTextField(
                          controller: model.passwordController,
                          hintText: 'Password',
                          isPassword: true,
                          maxLines: 1,
                          onChanged: (value) => model.onPasswordChanged(value),
                          textInputAction: TextInputAction.done,
                        ),
                        10.verticalSpace,
                        const PasswordRulesWidget(),
                        10.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<UserType>(
                                dense: true,
                                value: UserType.donor,
                                title: const Text('Donor'),
                                groupValue: model.userType,
                                onChanged: (type) =>
                                    model.onUserTypeChanged(type),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<UserType>(
                                dense: true,
                                value: UserType.recipient,
                                title: const Text('Recipient'),
                                groupValue: model.userType,
                                onChanged: (type) =>
                                    model.onUserTypeChanged(type),
                              ),
                            ),
                          ],
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
          ),
        );
      },
    );
  }
}
