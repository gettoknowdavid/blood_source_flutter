import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  Color primaryColor;

  HeaderPainter({this.primaryColor = AppColors.primary});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.swatch.shade800
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;
    // Paint paint2 = Paint()
    //   ..color = primaryColor.withOpacity(0.9)
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 8.0;
    Paint paint3 = Paint()
      ..color = AppColors.secondary.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    canvas.drawCircle(Offset(size.width * 0.26, size.height * 0.087),
        size.width * 0.7, paint);
    // canvas.drawCircle(Offset(size.width * 0.98, size.height * -0.001),
    //     size.width * 0.45, paint2);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * -0.01),
        size.width * 0.55, paint3);
  }

  @override
  bool shouldRepaint(HeaderPainter oldDelegate) {
    return primaryColor != oldDelegate.primaryColor;
  }
}
