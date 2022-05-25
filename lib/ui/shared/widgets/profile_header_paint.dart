import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColors.primary;
    Path path = Path()
      ..relativeLineTo(0.w, 120.w)
      ..quadraticBezierTo(size.width / 2, 220.w, size.width, 120.w)
      ..relativeLineTo(0.w, -120.w)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
