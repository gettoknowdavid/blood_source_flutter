import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked_services/stacked_services.dart';

class OnBoardingViewModel extends BaseViewModel with Initialisable {
  Future<void> init() async {}

  final NavigationService _navService = locator<NavigationService>();

  void goToSign() {
    if (FirebaseAuth.instance.currentUser != null) {
      _navService.clearStackAndShow(Routes.appLayoutView);
    } else {
      _navService.clearStackAndShow(Routes.signInView);
    }
  }

  Widget buildScreenImage(String filename) {
    return Image.asset(
      'assets/images/$filename',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget buildImage(String assetName, [double width = 350]) {
    return SizedBox(
      height: 0.5.sh,
      child: Image.asset('assets/images/$assetName', width: width.w),
    );
  }

  late Material materialButton;
  late int index;

  final onBoardingList = <PageModel>[
    PageModel(
      widget: Container(
        height: 1.sh,
        width: 1.sw,
        color: Colors.white,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                120.verticalSpace,
                SizedBox(
                  height: 0.45.sh,
                  width: 0.9.sw,
                  child: Image.asset('assets/images/onboarding-1.png'),
                ),
                40.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0.r),
                  child: Text(
                    'Find Donors',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0).r,
                  child: Text(
                    'Easily fnd donors close to you who are compatible with your blood group.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    PageModel(
      widget: Container(
        height: 1.sh,
        width: 1.sw,
        color: Colors.white,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              120.verticalSpace,
              SizedBox(
                height: 0.45.sh,
                width: 0.9.sw,
                child: Image.asset('assets/images/onboarding-2.png'),
              ),
              40.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0.r),
                child: Text(
                  'Testing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0).r,
                child: Text(
                  'Tested and approved blood donation events at your disposal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: Container(
        height: 1.sh,
        width: 1.sw,
        color: Colors.white,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              120.verticalSpace,
              SizedBox(
                height: 0.45.sh,
                width: 0.9.sw,
                child: Image.asset('assets/images/onboarding-3.png'),
              ),
              40.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0.r),
                child: Text(
                  'Receive Blood',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0).r,
                child: Text(
                  'Receive blood with ease and at preferred locations or registered blood banks.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initialise() {
    materialButton = skipButton();
    index = 0;
  }

  Material skipButton({void Function(int)? setIndex}) {
    final model = locator<OnBoardingViewModel>();

    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          // if (setIndex != null) {
          //   model.index = 2;
          //   setIndex(2);
          // }
          model.goToSign();
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get signUpButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {},
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Sign up',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
