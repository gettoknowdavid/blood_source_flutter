import 'package:blood_source/common/app_icons.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_details_item.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsList extends StatelessWidget {
  const ProfileDetailsList({Key? key, required this.user}) : super(key: key);
  final BloodSourceUser? user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      children: [
        ProfileDetailsItem(
          icon: const Icon(Icons.person),
          title: 'User Type',
          value: user!.userType.name.toUpperCase(),
        ),
        Divider(height: 1.h, color: Colors.black26),
        ProfileDetailsItem(
          icon: AppIcons.gender,
          title: 'Gender',
          value: user!.gender!.value,
        ),
        Divider(height: 1.h, color: Colors.black26),
        ProfileDetailsItem(
          icon: AppIcons.age,
          title: 'Age',
          value: user!.age.toString(),
        ),
        Divider(height: 1.h, color: Colors.black26),
        ProfileDetailsItem(
          icon: AppIcons.height,
          title: 'Height',
          value: user!.height.toString(),
        ),
        Divider(height: 1.h, color: Colors.black26),
        ProfileDetailsItem(
          icon: AppIcons.weight,
          title: 'Weight',
          value: user!.weight.toString(),
        ),
        Divider(height: 1.h, color: Colors.black26),
        ProfileDetailsItem(
          icon: const Icon(Icons.location_city),
          title: 'City',
          value: user!.city,
        ),
      ],
    );
  }
}
