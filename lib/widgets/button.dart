import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.colorBg,
      required this.label,
      required this.textColor,
      this.image,
      this.colorBorder});

  final double height;
  final double width;
  final Function()? onTap;
  final Color colorBg;
  final Color? colorBorder;
  final String label;
  final Color textColor;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: colorBorder ?? colorBg),
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBg,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
        child: image != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 16,
                        fontWeight: bold,
                        color: textColor),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  SvgPicture.asset(
                    image!,
                    width: 10.w,
                  ),
                ],
              )
            : Text(
                label,
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 16,
                    fontWeight: bold,
                    color: textColor),
              ),
      ),
    );
  }
}
