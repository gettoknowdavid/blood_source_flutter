import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

import './splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) async => await model.init(),
      fireOnModelReadyOnce: true,
      builder: (context, model, Widget? child) {
        return WidgetsApp(
          color: AppColors.primary,
          builder: (context, child) {
            final tsFactor = MediaQuery.of(context).textScaleFactor;
            final num constrainedTextScaleFactor = tsFactor.clamp(1.0, 1.5);

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: constrainedTextScaleFactor as double?,
              ),
              child: AnimatedSplashScreen(
                splash: Scaffold(
                  body: Container(
                    color: Colors.white,
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.95,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Image.asset(ImageResources.logo),
                      ),
                    ),
                  ),
                ),
                splashIconSize: 1000,
                backgroundColor: Colors.white,
                duration: 5000,
                pageTransitionType: PageTransitionType.fade,
                splashTransition: SplashTransition.fadeTransition,
                nextScreen: const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }
}
