import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>.reactive(
      viewModelBuilder: () => VerifyEmailViewModel(),
      onModelReady: (VerifyEmailViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        VerifyEmailViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: AppColors.primary.withOpacity(0.03),
              child: CustomPaint(
                painter: HeaderPainter(),
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Hello Again!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        4.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.r),
                          child: Text(
                            "Welcome back, you've been missed!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
