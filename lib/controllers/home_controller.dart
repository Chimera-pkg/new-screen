import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    print("Sign In Sign Up Screen is Start");
    super.onInit();
    tabController = TabController(vsync: this, length: 4);

    tabController.addListener(() {
      print("switch tab");
      selectedIndex.value = tabController.index;
      update();
    });
  }

  @override
  void onClose() {
    // tabController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    selectedIndex.value = index;
    tabController.index = selectedIndex.value;
    update();
  }
}
