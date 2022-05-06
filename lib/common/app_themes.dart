import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    fontFamily: 'Poppins',
    primarySwatch: AppColors.swatch,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.black87,
      background: AppColors.background,
    ),
  );
}
