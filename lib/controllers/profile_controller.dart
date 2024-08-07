import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class ProfileController extends GetxController {
  String token = "";
  final isLoading = false.obs;

  //individual
  final TextEditingController individualNameTextController =
      TextEditingController();
  final TextEditingController individualAddressTextController =
      TextEditingController();
  final TextEditingController individualZipCodeTextController =
      TextEditingController();
  final TextEditingController individualEmailTextController =
      TextEditingController();
  final TextEditingController individualPhoneTextController =
      TextEditingController();
  final TextEditingController individualWebsiteTextController =
      TextEditingController();
  //company
  final TextEditingController companyNameTextController =
      TextEditingController();
  final TextEditingController companyAddressTextController =
      TextEditingController();
  final TextEditingController companyZipCodeTextController =
      TextEditingController();
  final TextEditingController companyEmailTextController =
      TextEditingController();
  final TextEditingController companyPhoneTextController =
      TextEditingController();
  final TextEditingController companyWebsiteTextController =
      TextEditingController();

  @override
  void onInit() {
    print("Sign In Sign Up Screen is Start");
    super.onInit();
    checkUserRole();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> checkUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
    update();
  }

  Future<void> onSignOut() async {
    isLoading.value = true;
    update();
    try {
      await Amplify.Auth.signOut();
      Get.snackbar(
        'Logout Success',
        "",
        backgroundColor: Colors.green,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
      isLoading.value = false;
      update();
      Get.offAllNamed(RouteName.login);
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        "",
        backgroundColor: Colors.red,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
    }
    isLoading.value = false;
    update();
  }
}
