import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardPage1 extends StatelessWidget {
  const OnboardPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      // width: 100.w,
      // color: colorSecondary,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(
          "assets/images/running.jpeg",
        ),
      ),
    );
  }
}
