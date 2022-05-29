import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.alignment = Alignment.center,
    this.color = Colors.black,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final Alignment alignment;
  final Color? color;
  final double? fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: padding,
        alignment: alignment,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 14.sp,
          color: color,
          fontWeight: fontWeight,
          height: 1.sp,
        ),
      ),
    );
  }
}
