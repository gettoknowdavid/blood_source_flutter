import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.alignment = Alignment.center,
    this.textColor = Colors.black,
    this.fontSize,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final Alignment alignment;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: alignment,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16.sp,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
