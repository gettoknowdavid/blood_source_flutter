import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum BGWidgetType { simple, complex }

class BloodGroupWidget extends StatelessWidget {
  const BloodGroupWidget({
    Key? key,
    required this.bloodGroup,
    this.type = BGWidgetType.simple,
    this.compatible = true,
  }) : super(key: key);
  final BloodGroup bloodGroup;
  final BGWidgetType type;
  final bool compatible;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BGWidgetType.simple:
        return _Simple(bloodGroup: bloodGroup);
      case BGWidgetType.complex:
        return _Complex(bloodGroup: bloodGroup, compatible: compatible);
      default:
        return _Simple(bloodGroup: bloodGroup);
    }
  }
}

class _Simple extends StatelessWidget {
  const _Simple({Key? key, required this.bloodGroup}) : super(key: key);
  final BloodGroup bloodGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 20.r),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        bloodGroup.value.desc,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _Complex extends StatelessWidget {
  const _Complex({Key? key, required this.bloodGroup, required this.compatible})
      : super(key: key);
  final BloodGroup bloodGroup;
  final bool compatible;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: compatible ? 1.0 : 0.2,
        child: Container(
          height: 160.h,
          width: 107.w,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.03),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.swatch.shade500,
              width: 2.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 65.h,
                      width: 46.w,
                      child: Image.asset('assets/images/red-blood.png'),
                    ),
                  ),
                  Positioned(
                    left: 48.w,
                    top: 4.h,
                    child: Container(
                      height: 32.h,
                      width: 32.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF464A57),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          bloodGroup.value.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              5.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                child: Text(
                  bloodGroup.value.desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
