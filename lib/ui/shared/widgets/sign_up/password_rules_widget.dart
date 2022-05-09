import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/views/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRulesWidget extends ViewModelWidget<SignUpViewModel> {
  const PasswordRulesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Visibility(
      visible: viewModel.rulesVisibility,
      child: Column(
        children: [
          ...viewModel.rules.map((e) {
            final Color ruleColor = viewModel.passwordController.text.isEmpty
                ? Theme.of(context).primaryColorDark.withOpacity(0.3)
                : !e['rule'](
                        viewModel.passwordController.text,
                        viewModel.nameController.text,
                        viewModel.emailController.text)
                    ? AppColors.swatch.shade900
                    : Colors.green;

            return Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 14.sp,
                  color: ruleColor,
                ),
                4.horizontalSpace,
                Text(
                  e["name"].toString(),
                  style: TextStyle(fontSize: 14.sp, color: ruleColor),
                )
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
