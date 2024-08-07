import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class InviteEmployeeController extends GetxController {
  int emailFieldCount = 1;
  List<TextEditingController> emailController = [];

  @override
  void onInit() {
    print("Sign In Sign Up Screen is Start");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void incrementEmailField() {
    emailFieldCount++;
    if (emailFieldCount == 5)
      Get.snackbar(
        'Maximum limit reached',
        'You can only send up to 5 invites at a time',
        backgroundColor: Colors.amber,
        colorText: colorWhite,
        icon: const Icon(
          Icons.check,
          color: colorWhite,
        ),
      );
    update();
  }
}
