import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/app_icons.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/ui/shared/widgets/profile/avatar.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_details_item.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_details_list.dart';
import 'package:blood_source/ui/shared/widgets/profile_header_paint.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                CustomPaint(
                  child: SizedBox(height: 1.sh, width: 1.sw),
                  painter: ProfileHeaderPainter(),
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        100.verticalSpace,
                        const Avatar(),
                        10.verticalSpace,
                        Text(
                          model.data!.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          model.data!.email!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                        2.verticalSpace,
                        model.data!.phone == null
                            ? const SizedBox()
                            : Text(
                                model.data!.phone!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                              ),
                        20.verticalSpace,
                        const BloodGroupWidget(),
                        40.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Donations',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            100.horizontalSpace,
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Requests',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        40.verticalSpace,
                        const ProfileDetailsList(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileActionButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      ProfileActionButton(
                        icon: const Icon(Icons.power_settings_new),
                        onPressed: () => model.signOut(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ProfileActionButton extends StatelessWidget {
  const ProfileActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      width: 46.h,
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        padding: EdgeInsets.all(1.r),
        icon: icon,
      ),
    );
  }
}
