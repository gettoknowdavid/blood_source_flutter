import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/ui/views/donor/donor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

class DonorListItem extends ViewModelWidget<DonorViewModel> {
  const DonorListItem({Key? key, required this.donor}) : super(key: key);

  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context, DonorViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.r),
      padding: EdgeInsets.symmetric(vertical: 12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 0,
            color: Colors.black12,
            offset: Offset(0, 10.h),
          )
        ],
      ),
      child: ListTile(
        onTap: () => viewModel.goToDonorDetails(donor),
        leading: GestureDetector(
          onTap: () => viewModel.goToDonorProfile(donor),
          child: CircleAvatar(
            radius: 25.w,
            backgroundColor: AppColors.swatch.shade400,
            child: donor.avatar == null
                ? const Icon(PhosphorIcons.user, color: Colors.white)
                : const SizedBox(),
            foregroundImage:
                donor.avatar != null ? NetworkImage(donor.avatar!) : null,
          ),
        ),
        title: Text(
          donor.name!,
          style: TextStyle(fontSize: 15.sp),
        ),
        isThreeLine: true,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              PhosphorIcons.mapPinBold,
              color: AppColors.secondary,
              size: 15.sp,
            ),
            2.horizontalSpace,
            Text(
              donor.city!,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        trailing: Container(
          height: 40.h,
          width: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.swatch.shade600,
          ),
          child: Text(
            donor.bloodGroup!.value.name,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
