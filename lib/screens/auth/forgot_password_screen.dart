import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/forgot_password_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        // reverse: true,
        child: Padding(
          padding: EdgeInsets.only(
            right: defaultPadding,
            left: defaultPadding,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 24,
                      fontWeight: bold,
                      color: colorBlack),
                ),
                Text(
                  "Enter Your Username Account To Reset",
                  style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 16,
                    fontWeight: medium,
                    color: Colors.blueGrey[800],
                  ),
                ),
                Text(
                  "Your Password",
                  style: GoogleFonts.poppins(
                    fontSize: 4.w,
                    fontWeight: light,
                    color: colorBlack,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 13,
                      fontWeight: bold,
                      color: colorNavy),
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                      colors: [Colors.white, colorGrey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.usernameTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Button(
                  height: 6.h,
                  width: 100.w,
                  onTap: () {
                    controller.onRecoverPassword();
                  },
                  colorBg: colorNavy,
                  label: "Reset Password",
                  textColor: colorWhite,
                ),
              ]),
        ),
      ),
    );
  }
}
