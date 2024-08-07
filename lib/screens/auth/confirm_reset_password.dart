import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/forgot_password_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';
import 'package:skribex_app/widgets/form_password_textfield.dart';

class ConfirmResetPassword extends StatelessWidget {
  const ConfirmResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
      body: Padding(
        padding: const EdgeInsets.only(
          right: defaultPadding,
          left: defaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 1.5.h,
            ),
            Text(
              "Reset Password",
              style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 24,
                  fontWeight: bold,
                  color: colorBlack),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormInputTextField(
                    label: "Code Verification",
                    inputController: controller.codeConfirmationTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormPasswordTextField(
                    label: "New Password",
                    isObsecured: controller.isObsecuredNewPass,
                    passwordController: controller.newPasswordTextController,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  FormPasswordTextField(
                    label: "Confirm Password",
                    isObsecured: controller.isObsecuredConfirmPass,
                    passwordController:
                        controller.confirmNewPasswordTextController,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Button(
              height: 6.h,
              width: 100.w,
              onTap: () {
                // print("masuk");
                if (controller.newPasswordTextController.text ==
                    controller.confirmNewPasswordTextController.text) {
                  controller.resetPassword();
                } else {
                  Get.snackbar(
                    'Incorrect Password',
                    "",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  );
                }
              },
              colorBg: colorNavy,
              label: "Reset Password",
              textColor: colorWhite,
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
