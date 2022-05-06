import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.buttonColor,
    this.shadowColor,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: buttonColor ?? AppColors.swatch.shade700,
        padding: EdgeInsets.all(23.r),
        shadowColor: shadowColor ?? AppColors.swatch.shade400,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        'Sign In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.5.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
