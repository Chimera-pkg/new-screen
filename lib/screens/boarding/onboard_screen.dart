import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';

import 'onboard_page1.dart';
import 'onboard_page2.dart';
import 'onboard_page3.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: OnBoardingSlider(
        // pageBackgroundColor: colorSecondary,
        headerBackgroundColor: colorSecondary,

        finishButtonText: 'Login',
        finishButtonTextStyle: TextStyle(color: Colors.black),
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Colors.white,
        ),
        onFinish: () => Get.toNamed(RouteName.login),
        skipIcon: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            color: colorSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        background: [
          Container(
            color: Colors.red,
            height: 1000.h,
            width: 30,
          ),
          Container(),
          Container(),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          OnboardPage1(),
          OnboardPage1(),
          OnboardPage1(),
          // OnboardPage2(),
          // OnboardPage3(),
        ],
      ),
    );
  }
}
