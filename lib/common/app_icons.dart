import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcons {
  static ImageIcon bell = ImageIcon(
    const AssetImage('assets/images/bell.png'),
    size: 22.sp,
  );
  static ImageIcon blood = ImageIcon(
    const AssetImage('assets/images/blood.png'),
    size: 22.sp,
    color: Colors.white,
  );
  static ImageIcon home = ImageIcon(
    const AssetImage('assets/images/home.png'),
    size: 22.sp,
  );
  static ImageIcon profile = ImageIcon(
    const AssetImage('assets/images/profile.png'),
    size: 22.sp,
  );
  static ImageIcon settings = ImageIcon(
    const AssetImage('assets/images/settings.png'),
    size: 22.sp,
  );
  static ImageIcon locationPin = const ImageIcon(
    AssetImage('assets/images/location.png'),
    color: AppColors.secondary,
  );
  static ImageIcon gender = ImageIcon(
    const AssetImage('assets/images/gender.png'),
    size: 24.sp,
  );
  static ImageIcon age = ImageIcon(
    const AssetImage('assets/images/age.png'),
    size: 24.sp,
  );
  static ImageIcon height = ImageIcon(
    const AssetImage('assets/images/height.png'),
    size: 24.sp,
  );
  static ImageIcon weight = ImageIcon(
    const AssetImage('assets/images/weight.png'),
    size: 24.sp,
  );
}
