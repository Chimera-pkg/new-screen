import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          // padding: EdgeInsets.all(16.0),
          fixedSize: const Size(2, 55),
        ),
        child: SvgPicture.asset(
          "assets/icons/google_logo.svg",
        ),
      ),
    );
  }
}
