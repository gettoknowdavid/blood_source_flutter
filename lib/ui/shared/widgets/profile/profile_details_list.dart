import 'package:blood_source/common/app_icons.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_details_item.dart';
import 'package:blood_source/ui/views/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsList extends ViewModelWidget<ProfileViewModel> {
  const ProfileDetailsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    if (viewModel.isBusy) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return ListView(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32).r,
        children: [
          Title(
            color: Colors.black,
            child: Text(
              'Other Details',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          ProfileDetailsItem(
            icon: AppIcons.gender,
            title: 'Gender',
            value: Gender.values[viewModel.data!.gender!.index].value,
          ),
          ProfileDetailsItem(
            icon: AppIcons.age,
            title: 'Age',
            value: viewModel.data!.age.toString(),
          ),
          ProfileDetailsItem(
            icon: AppIcons.height,
            title: 'Height',
            value: viewModel.data!.height.toString(),
          ),
          ProfileDetailsItem(
            icon: AppIcons.weight,
            title: 'Weight',
            value: viewModel.data!.weight.toString(),
            showSeparator: false,
          ),
        ],
      );
    }
  }
}
