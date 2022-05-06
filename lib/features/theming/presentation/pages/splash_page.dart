import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/features/auth/presentation/pages/login_page.dart';
import 'package:blood_source/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Image.asset(
                ImageResources.logo,
              ),
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
            return const MyHomePage(title: 'BloodSource');
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
