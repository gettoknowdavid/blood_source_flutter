import 'package:blood_source/common/image_resources.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
