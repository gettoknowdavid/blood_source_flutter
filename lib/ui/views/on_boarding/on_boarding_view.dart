import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import './on_boarding_view_model.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();

    final bodyStyle = TextStyle(
      color: Colors.black87,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0.sp, fontWeight: FontWeight.w600),
      titlePadding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 10.0).r,
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0).r,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      imageFlex: 2,
      bodyFlex: 1,
    );

    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      viewModelBuilder: () => OnBoardingViewModel(),
      onModelReady: (OnBoardingViewModel model) async {
        await model.init();
      },
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            onDone: model.goToSign,
            onSkip: model.goToSign, // You can override onSkip callback
            showSkipButton: true,
            skipOrBackFlex: 0,
            nextFlex: 0,
            // showBackButton: true,
            //rtl: true, // Display as right-to-left
            back: const Icon(PhosphorIcons.arrowBendUpLeft),
            skip: const Text('Skip'),
            next: const Icon(PhosphorIcons.arrowBendUpRight),
            done: const Text(
              'Done',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 4.0),
              color: AppColors.secondary,
              activeSize: Size(22.0, 4.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            pages: [
              PageViewModel(
                title: "Find Donors",
                body: 'Easily fnd donors close to you who are '
                    'compatible with your blood group.',
                image: model.buildImage('onboarding-1.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: 'Testing',
                body: 'Tested and approved blood '
                    'donation events at your disposal.',
                image: model.buildImage('onboarding-2.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: 'Donated',
                body: 'Receive blood with ease and at '
                    'preferred locations or registered blood banks.',
                image: model.buildImage('onboarding-3.png'),
                decoration: pageDecoration,
              )
            ],
          ),
        );
      },
    );
  }
}



/*
 Onboarding(
            pages: model.onBoardingList,
            onPageChange: (int pageIndex) => model.index = pageIndex,
            startPageIndex: 0,
            footerBuilder: (context, dragDistance, pagesLength, setIndex) {
              return DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIndicator(
                          netDragPercent: dragDistance,
                          pagesLength: pagesLength,
                          indicator: Indicator(
                            closedIndicator: const ClosedIndicator(
                              color: AppColors.primaryDark,
                            ),
                            activeIndicator: ActiveIndicator(
                              color: AppColors.swatch.shade100,
                            ),
                            indicatorDesign: IndicatorDesign.line(
                              lineDesign: LineDesign(
                                lineType: DesignType.line_uniform,
                              ),
                            ),
                          ),
                        ),
                        model.index == pagesLength - 1
                            ? model.signUpButton
                            : model.skipButton(setIndex: setIndex)
                      ],
                    ),
                  ),
                ),
              );
            },
          )
          */