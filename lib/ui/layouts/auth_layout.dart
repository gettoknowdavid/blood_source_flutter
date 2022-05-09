import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    Key? key,
    required this.child,
    this.showBackButton = false,
  }) : super(key: key);

  final Widget child;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.06),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomPaint(
                painter: HeaderPainter(),
                child: Center(child: child),
              ),
            ),
            showBackButton ? const AppBackButton() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
