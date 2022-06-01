import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_source/models/blood_group.dart';

class DonorListItem extends StatelessWidget {
  const DonorListItem({Key? key, required this.donor}) : super(key: key);

  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        leading: CircleAvatar(
          radius: 25.w,
          backgroundColor: AppColors.swatch.shade400,
          foregroundImage: NetworkImage(donor.avatar!),
        ),
        title: Text(
          donor.name!,
          style: TextStyle(fontSize: 17.sp),
        ),
        isThreeLine: true,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_pin,
              color: AppColors.secondary,
              size: 18.sp,
            ),
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
          height: 46.h,
          width: 46.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.secondary,
          ),
          child: Text(
            donor.bloodGroup!.value.name,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
