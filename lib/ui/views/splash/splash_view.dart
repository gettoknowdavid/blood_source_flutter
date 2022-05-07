import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/views/home/home_view.dart';
import 'package:blood_source/ui/views/sign_in/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      onModelReady: (SplashViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        SplashViewModel model,
        Widget? child,
      ) {
        return AnimatedSplashScreen(
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
          nextScreen: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeView();
              } else {
                return const SignInView();
              }
            },
          ),
        );
      },
    );
  }
}
