import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/ui/views/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class BloodGroupWidget extends ViewModelWidget<ProfileViewModel> {
  const BloodGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        BloodGroup.values[viewModel.data!.bloodGroup!.index].value.desc,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
