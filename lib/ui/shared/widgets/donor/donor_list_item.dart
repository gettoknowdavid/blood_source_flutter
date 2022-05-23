import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonorListItem extends StatelessWidget {
  const DonorListItem({Key? key, required this.donor}) : super(key: key);

  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        vertical: 10.r,
        horizontal: 16.r,
      ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25.w,
            backgroundColor: AppColors.swatch.shade400,
            foregroundImage: NetworkImage(donor.avatar),
          ),
          10.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${donor.firstName} ${donor.lastName}',
                style: TextStyle(fontSize: 17.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: AppColors.secondary,
                    size: 18.sp,
                  ),
                  Text(
                    donor.city,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 46.h,
            width: 46.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: const Color(0xFF826DEE),
            ),
            child: Text(
              '5km',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
