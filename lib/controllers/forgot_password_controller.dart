import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribex_app/models/auth_model.dart';
import 'package:skribex_app/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController codeConfirmationTextController =
      TextEditingController();
  final TextEditingController newPasswordTextController =
      TextEditingController();
  final TextEditingController confirmNewPasswordTextController =
      TextEditingController();
  final AuthModel _authModel = AuthModel();
  final isObsecuredNewPass = true.obs;
  final isObsecuredConfirmPass = true.obs;
  @override
  void onInit() {
    print("Sign In Sign Up Screen is Start");
    super.onInit();
  }

  @override
  void onClose() {
    usernameTextController.dispose();
    super.onClose();
  }

  Future<void> onRecoverPassword() async {
    try {
      final res = await _authModel.resetPassword(usernameTextController.text);

      print(res);
      if (res.nextStep.updateStep ==
          AuthResetPasswordStep.confirmResetPasswordWithCode) {
        print("Confirm reset password with code");
        Get.snackbar(
          'Reset Password Success',
          "Confirmation code resent. Check you email box",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.cancel,
            color: Colors.white,
          ),
        );

        Get.toNamed(RouteName.confirmResetPassword);
      }
    } on AuthException catch (e) {
      Get.snackbar(
        'Reset Password Failed',
        "${e.message}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Reset Password Failed',
        "",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
      );
    }
  }

  Future<void> resetPassword() async {
    ResetPasswordResult res;

    try {
      var input = <String, dynamic>{
        'username': usernameTextController.text,
        'new_password': newPasswordTextController.text,
        'confim_code': codeConfirmationTextController.text,
      };

      res = await _authModel.confirmResetPassword(input);

      print('Reset Result: ${res.isPasswordReset}');
      if (res.isPasswordReset) {
        print("Reset password complete");

        Get.snackbar(
          'Reset Password Success',
          "Password reset completed successfully, Please login",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.cancel,
            color: Colors.white,
          ),
        );

        Get.offAllNamed(RouteName.login);
      } else {
        Get.snackbar(
          'Reset Password Failed',
          "",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.cancel,
            color: Colors.white,
          ),
        );
      }
    } on AuthException catch (e) {
      print("ini error ${e.message}");
      Get.snackbar(
        'Reset Password Failed',
        "${e.message}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
      );
    }
  }
}
