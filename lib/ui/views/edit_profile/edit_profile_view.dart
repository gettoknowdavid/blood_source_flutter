import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/profile/avatar.dart';
import 'package:blood_source/ui/shared/widgets/profile_header_paint.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.primary,
            leading: const AppBackButton(),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Save'),
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
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      100.verticalSpace,
                      GestureDetector(
                        onTap: model.getImage,
                        child: CircleAvatar(
                          radius: 0.18 * 1.sw,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 0.17 * 1.sw,
                            foregroundColor: AppColors.primary,
                            foregroundImage: model.image != null
                                ? FileImage(model.image!)
                                : null,
                            child: model.image == null
                                ? const Icon(Icons.add_a_photo)
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
