import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/views/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class Avatar extends ViewModelWidget<ProfileViewModel> {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return CircleAvatar(
      radius: 0.18 * 1.sw,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 0.17 * 1.sw,
        foregroundColor: AppColors.primary,
        child: viewModel.isBusy
            ? const CircularProgressIndicator()
            : const Icon(Icons.add_a_photo),
        foregroundImage: viewModel.data!.avatar != null
            ? NetworkImage(viewModel.data!.avatar!)
            : null,
      ),
    );
  }
}
