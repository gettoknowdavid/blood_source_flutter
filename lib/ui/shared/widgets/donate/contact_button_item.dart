import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/contact_button_model.dart';
import 'package:blood_source/ui/views/donate/donate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class ContactButtonItem extends ViewModelWidget<DonateViewModel> {
  const ContactButtonItem({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  final ContactButtonModel model;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, DonateViewModel viewModel) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 0.5 * 1.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 10,
              color: Colors.black.withOpacity(0.01),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(24.r),
              child: Icon(model.icon, color: AppColors.primary),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.backgroundColor.withOpacity(0.2),
              ),
            ),
            12.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.r),
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
