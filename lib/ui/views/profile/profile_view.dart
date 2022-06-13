import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:blood_source/ui/shared/widgets/profile/avatar.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:blood_source/ui/shared/widgets/profile/profile_details_list.dart';
import 'package:blood_source/ui/shared/widgets/profile_header_paint.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, this.user, this.isFromRoute = false})
      : super(key: key);
  final BloodSourceUser? user;
  final bool isFromRoute;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) async => await model.init(),
      fireOnModelReadyOnce: false,
      createNewModelOnInsert: true,
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        if (!model.isConnected!) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: !isFromRoute
                  ? const SizedBox()
                  : const AppBackButton(color: AppColors.primary),
            ),
            body: OfflineWidget(
              onTap: model.checkConnectivity,
              addPadding: true,
            ),
          );
        }

        final profile = isFromRoute ? user : model.user;
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            title: const Text('Profile'),
            backgroundColor: AppColors.primary,
            centerTitle: true,
            leading: isFromRoute
                ? const AppBackButton()
                : IconButton(
                    icon: const Icon(PhosphorIcons.pencil),
                    onPressed: () => model.goToEditProfile(model.user),
                  ),
            actions: [
              isFromRoute
                  ? const SizedBox()
                  : IconButton(
                      icon: const Icon(PhosphorIcons.signOut),
                      onPressed: () => model.signOut(),
                    ),
            ],
          ),
          body: Stack(
            children: [
              CustomPaint(
                child: SizedBox(height: 1.sh, width: 1.sw),
                painter: ProfileHeaderPainter(),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Avatar(avatar: profile!.avatar),
                    20.verticalSpace,
                    Text(
                      profile.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      profile.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    2.verticalSpace,
                    profile.phone == null
                        ? const SizedBox()
                        : Text(
                            profile.phone!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                    20.verticalSpace,
                    BloodGroupWidget(bloodGroup: profile.bloodGroup!),
                    20.verticalSpace,
                    ProfileDetailsList(user: profile),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
