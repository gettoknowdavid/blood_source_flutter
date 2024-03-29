import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:blood_source/ui/views/donor_details/donor_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';

class DonorMapPanel extends ViewModelWidget<DonorDetailsViewModel> {
  const DonorMapPanel({
    Key? key,
    required this.controller,
    required this.donor,
  }) : super(key: key);

  final ScrollController controller;
  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context, DonorDetailsViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: 4.h,
              width: 0.2.sw,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => viewModel.goToDonorProfile(donor),
                child: CircleAvatar(
                  radius: 0.09.sw,
                  foregroundColor: AppColors.primary,
                  foregroundImage: NetworkImage(donor.avatar!),
                ),
              ),
              20.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donor.name!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'City: ${donor.city!}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Age: ${donor.age!}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppTextButton(
            onTap: () => viewModel.goToDonorProfile(donor),
            text: 'View Profile',
            color: AppColors.primary,
            padding: EdgeInsets.only(left: 4.r),
            alignment: Alignment.centerLeft,
            fontSize: 12.sp,
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BloodGroupWidget(
                bloodGroup: viewModel.recipient.bloodGroup!,
                type: BGWidgetType.complex,
                // compatible: compatible,
              ),
              10.horizontalSpace,
              const Icon(Icons.chevron_left, color: AppColors.primary),
              10.horizontalSpace,
              BloodGroupWidget(
                bloodGroup: donor.bloodGroup!,
                type: BGWidgetType.complex,
              ),
            ],
          ),
          32.verticalSpace,
          AppButton(
            onTap: () => viewModel.goToDonate(donor),
            text: 'Contact Donor',
          )
        ],
      ),
    );
  }
}
