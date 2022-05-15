import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  Color primaryColor;

  HeaderPainter({this.primaryColor = AppColors.primary});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.swatch.shade900
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;
    // Paint paint2 = Paint()
    //   ..color = AppColors.secondary.withOpacity(0.5)
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 8.0;
    Paint paint3 = Paint()
      ..color = AppColors.secondary.withOpacity(0.07)
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.16), size.width * 0.7, paint);
    // canvas.drawCircle(Offset(size.width * 0.1, size.height * -0.001),
    //     size.width * 0.45, paint2);
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 1.14), size.width * 1.3, paint3);
  }

  @override
  bool shouldRepaint(HeaderPainter oldDelegate) {
    return primaryColor != oldDelegate.primaryColor;
  }
}
