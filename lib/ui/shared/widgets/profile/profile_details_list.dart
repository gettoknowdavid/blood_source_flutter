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
            value: Gender.values[viewModel.user.gender!.index].value,
          ),
          Divider(height: 1.h, color: Colors.black26),
          ProfileDetailsItem(
            icon: AppIcons.age,
            title: 'Age',
            value: viewModel.user.age.toString(),
          ),
          Divider(height: 1.h, color: Colors.black26),
          ProfileDetailsItem(
            icon: AppIcons.height,
            title: 'Height',
            value: viewModel.user.height.toString(),
          ),
          Divider(height: 1.h, color: Colors.black26),
          ProfileDetailsItem(
            icon: AppIcons.weight,
            title: 'Weight',
            value: viewModel.user.weight.toString(),
          ),
          Divider(height: 1.h, color: Colors.black26),
          ProfileDetailsItem(
            icon: const Icon(Icons.location_city),
            title: 'City',
            value: viewModel.user.city,
          ),
        ],
      );
    }
  }
}
