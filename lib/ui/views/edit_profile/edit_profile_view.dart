import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/gender.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/profile/avatar.dart';
import 'package:blood_source/ui/shared/widgets/profile_header_paint.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_source/models/blood_source_user.dart';

import './edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key, required this.user}) : super(key: key);
  final BloodSourceUser user;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.primary,
            leading: const AppBackButton(),
            actions: [
              TextButton(
                onPressed: () => model.save(),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                            backgroundImage: user.avatar != null
                                ? NetworkImage(user.avatar!)
                                : null,
                            child: model.image == null
                                ? const Icon(Icons.add_a_photo)
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      AppTextField(
                        controller: model.nameController,
                        label: 'Name',
                      ),
                      15.verticalSpace,
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender', style: TextStyle(fontSize: 11.r)),
                            DropdownButton<Gender>(
                              value: model.gender,
                              borderRadius: BorderRadius.circular(20.r),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                              onChanged: (value) =>
                                  model.onGenderChanged(value),
                              items: Gender.values
                                  .map<DropdownMenuItem<Gender>>((e) {
                                return DropdownMenuItem<Gender>(
                                  value: e,
                                  child: Text(e.value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      25.verticalSpace,
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Blood Group',
                                style: TextStyle(fontSize: 11.r)),
                            DropdownButton<BloodGroup>(
                              value: model.bloodType,
                              borderRadius: BorderRadius.circular(20.r),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black87,
                              ),
                              onChanged: (value) =>
                                  model.onBloodGroupChanged(value),
                              underline:
                                  Container(height: 1.h, color: Colors.grey),
                              itemHeight: 56.h,
                              items: BloodGroup.values
                                  .map<DropdownMenuItem<BloodGroup>>((e) {
                                return DropdownMenuItem<BloodGroup>(
                                  value: e,
                                  child: Text(e.value.desc),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      AppTextField(
                        controller: model.ageController,
                        label: 'Age',
                        keyboardType: TextInputType.number,
                      ),
                      15.verticalSpace,
                      AppTextField(
                        controller: model.phoneController,
                        label: 'Phone',
                        hintText: 'Phone',
                        keyboardType: TextInputType.phone,
                      ),
                      15.verticalSpace,
                      AppTextField(
                        controller: model.weightController,
                        label: 'Weight',
                        keyboardType: TextInputType.number,
                      ),
                      15.verticalSpace,
                      AppTextField(
                        controller: model.heightController,
                        label: 'Height',
                        keyboardType: TextInputType.number,
                      ),
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
