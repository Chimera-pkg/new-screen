import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class IconNavbar extends StatelessWidget {
  const IconNavbar(
      {Key? key,
      required this.text,
      required this.selected,
      required this.onPressed,
      required this.iconEnable,
      required this.iconDisable})
      : super(key: key);
  final String text;
  final String iconEnable;
  final String iconDisable;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: FittedBox(
        fit: BoxFit.none,
        child: Container(
          color: colorWhite,
          width: 30.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: selected
                    ? SvgPicture.asset(
                        iconEnable,
                        width: 37,
                        height: 37,
                      )
                    : SvgPicture.asset(
                        iconDisable,
                        width: 20,
                        height: 20,
                      ),
              ),
              const SizedBox(
                height: 5,
              ),
              selected
                  ? Text(
                      text,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: semiBold,
                          color: colorPrimary),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                          fontSize: 10, fontWeight: semiBold, color: colorGrey),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
