import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/auth_controller.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';
import 'package:skribex_app/widgets/form_password_textfield.dart';
import 'package:skribex_app/widgets/google_button.dart';

final authController = Get.find<AuthController>();

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35.0),
            Image.asset(
              "assets/icons/tiktraq.png",
              height: 65,
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please select your registration ",
                        style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 15,
                            fontWeight: light,
                            color: colorBlack),
                      ),
                      Text(
                        "type",
                        style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 15,
                            fontWeight: light,
                            color: colorDarkBlue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Button(
                    height: 6.h,
                    width: 100.w,
                    onTap: () {
                      Get.toNamed(RouteName.companyRegister);
                    },
                    colorBg: colorNavy,
                    label: "Register as Company",
                    textColor: colorWhite,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Text(
                      'OR',
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 15,
                          fontWeight: regular,
                          color: colorDarkGrey),
                    ),
                  ),
                  Button(
                    height: 6.h,
                    width: 100.w,
                    onTap: () {
                      Get.toNamed(RouteName.individualRegister);
                    },
                    colorBg: colorWhite,
                    colorBorder: colorNavy,
                    label: "Register as individual",
                    textColor: colorNavy,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account? ",
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 15,
                      fontWeight: light,
                      color: colorBlack),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(RouteName.login);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 15,
                        fontWeight: semiBold,
                        color: colorDarkBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IndividualRegistration extends StatelessWidget {
  IndividualRegistration({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          right: defaultPadding,
          left: defaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Individual Registration',
              style: GoogleFonts.lato(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: colorBlack,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Please Provide your detailed information. (* Required)',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormInputTextField(
                    label: "Email",
                    inputController: authController.emailRegisterTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormPasswordTextField(
                    label: "Password",
                    isObsecured: authController.isObsecuredPasswordRegister,
                    passwordController:
                        authController.passwordRegisterTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormPasswordTextField(
                    label: "Confirm Password",
                    isObsecured:
                        authController.isObsecuredConfirmPasswordRegister,
                    passwordController:
                        authController.confirmPasswordRegisterTextController,
                  ),
                  SizedBox(height: 3.h),
                  Button(
                    height: 6.h,
                    width: 100.w,
                    onTap: () {
                      authController.onSignup();
                    },
                    colorBg: colorNavy,
                    label: "Sign Up",
                    textColor: colorWhite,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 15,
                          fontWeight: regular,
                          color: colorDarkGrey),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GoogleButton(
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account?",
                  style: GoogleFonts.raleway(
                    fontWeight: light,
                    color: colorBlack,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(RouteName.login);
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.raleway(
                      fontWeight: medium,
                      color: colorBlack,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyRegistration extends StatelessWidget {
  const CompanyRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          right: defaultPadding,
          left: defaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1.5.h,
            ),
            Text(
              'Company Registration',
              style: GoogleFonts.lato(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: colorBlack,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Please Provide your detailed Company information. (* Required)',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 40.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormInputTextField(
                    label: "Email",
                    inputController: authController.emailRegisterTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormInputTextField(
                    label: "Company Email",
                    inputController:
                        authController.companyEmailRegisterTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormPasswordTextField(
                    label: "Password",
                    isObsecured: authController.isObsecuredPasswordRegister,
                    passwordController:
                        authController.passwordRegisterTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormPasswordTextField(
                    label: "Confirm Password",
                    isObsecured:
                        authController.isObsecuredConfirmPasswordRegister,
                    passwordController:
                        authController.confirmPasswordRegisterTextController,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.5.h,
            ),
            Button(
              height: 6.h,
              width: 100.w,
              onTap: () {},
              colorBg: colorNavy,
              label: " Submit",
              textColor: colorWhite,
            ),
            SizedBox(
              height: 3.5.h,
            ),
          ],
        ),
      ),
    );
  }
}
