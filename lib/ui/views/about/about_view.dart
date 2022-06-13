import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './about_view_model.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
      viewModelBuilder: () => AboutViewModel(),
      onModelReady: (AboutViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        AboutViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo-splash.png', width: 0.9.sw),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0.r),
                  child: Text(
                    'The Blood Source Donation mobile application was built with love by Joy Emah and inspired by David Michael.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
