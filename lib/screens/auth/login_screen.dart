import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/auth_controller.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/form_password_textfield.dart';
import 'package:skribex_app/widgets/google_button.dart';
import 'package:skribex_app/widgets/search_bar.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(toolbarHeight: 2, backgroundColor: colorBackground),
        backgroundColor: colorBackground,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 24,
                        fontWeight: semiBold,
                        color: colorNavy),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 36,
                        fontWeight: semiBold,
                        color: colorNavy),
                  ),
                ),
                const SizedBox(height: 25.0),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/tiktraq.png",
                          height: 50,
                        ),
                        const SizedBox(height: 25.0),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: colorPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FormInputTextField(
                                label: "Email",
                                inputController:
                                    controller.usernameLoginTextController,
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              FormPasswordTextField(
                                label: "Password",
                                isObsecured: controller.isObsecured,
                                passwordController:
                                    controller.passwordLoginTextController,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 3.h, top: 1.h),
                                width: 100.w,
                                child: GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(RouteName.forgotPassword),
                                  child: Text(
                                    "Forgot Password",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontFamily: 'MonaSans',
                                        fontSize: 13,
                                        fontWeight: bold,
                                        color: colorNavy),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Button(
                                height: 6.h,
                                width: 100.w,
                                onTap: () {
                                  controller.onLogin(
                                      controller
                                          .usernameLoginTextController.text,
                                      controller
                                          .passwordLoginTextController.text);
                                  // Get.toNamed(RouteName.confirmResetPassword);
                                },
                                colorBg: colorNavy,
                                label: "Sign In",
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
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 15,
                          fontWeight: light,
                          color: colorNavy),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouteName.register);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 15,
                            fontWeight: semiBold,
                            color: colorNavy),
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (controller.isLoading.value)
              ModalBarrier(
                color: Colors.black54,
                dismissible: false,
              ),
            Visibility(
              child: Center(
                  child: GestureDetector(
                      onTap: () {
                        controller.isLoading.value = false;
                      },
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: colorPrimary, size: 30))),
              visible: controller.isLoading.value,
            )
          ],
        ),
      ),
    );
  }
}

class SelectUserAccount extends StatelessWidget {
  const SelectUserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
        child: Column(children: [
          SizedBox(
            height: 5.h,
          ),
          Image.asset(
            "assets/icons/tiktraq.png",
            height: 50,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Select User Account",
            style: TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 16,
                fontWeight: medium,
                color: colorDarkGrey),
          ),
          SizedBox(
            height: 1.h,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.inviteEmployee);
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Invite Employees",
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 12,
                    fontWeight: semiBold,
                    color: colorNavy,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const SearchBarApp(),
          const Divider(
            color: colorDarkGrey,
          ),
          employeAccount(1),
          employeAccount(2),
          employeAccount(3),
          employeAccount(4),
        ]),
      ),
    );
  }

  Widget employeAccount(int index) {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed(RouteName.navigation);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: defaultBorderRadius,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 7.5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colorPrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
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
                      child: SvgPicture.asset("assets/icons/person.svg")),
                  SizedBox(width: 3.w),
                  Text(
                    "Empployee $index",
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 13,
                        fontWeight: bold,
                        color: colorLightGrey2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
