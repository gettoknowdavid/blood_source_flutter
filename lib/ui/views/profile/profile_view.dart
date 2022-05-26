import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/profile/avatar.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_action_button.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_details_list.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_stat_widget.dart';
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
      fireOnModelReadyOnce: false,
      createNewModelOnInsert: true,
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
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
                          model.user.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          model.user.email!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                        2.verticalSpace,
                        model.user.phone == null
                            ? const SizedBox()
                            : Text(
                                model.user.phone!,
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
                            const ProfileStatWidget(
                              stat: 16,
                              title: 'Donations',
                            ),
                            100.horizontalSpace,
                            const ProfileStatWidget(stat: 2, title: 'Requests'),
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
                        onPressed: () => model.goToEditProfile(model.user),
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
