import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/home_controller.dart';
import 'package:skribex_app/controllers/navigation_controller.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/screens/home/home_sceen.dart';
import 'package:skribex_app/screens/profile/profile_screen.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/icon_navbar.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});
  final NavigationController controller = Get.find();
  final Homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavigationController>(
        builder: (c) {
          return IndexedStack(
            index: controller.tabIndex,
            children: [
              HomePage(),
              // ExpenseScreen(),
              // ProfileScreen()
              const SizedBox()
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: colorWhite,
        child: SizedBox(
          height: 8.h,
          width: 100.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: GetBuilder<NavigationController>(
              init: NavigationController(),
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconNavbar(
                      text: "Home",
                      iconEnable: "assets/icons/home.svg",
                      iconDisable: "assets/icons/home.svg",
                      selected: controller.tabIndex == 0 ? true : false,
                      onPressed: () {
                        controller.changeTabIndex(0);
                      },
                    ),
                    IconNavbar(
                      text: "Profile",
                      iconEnable: "assets/icons/profile.svg",
                      iconDisable: "assets/icons/profile.svg",
                      selected: controller.tabIndex == 2 ? true : false,
                      onPressed: () {
                        // controller.changeTabIndex(1);
                        Get.toNamed(RouteName.profile);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20.0), // Adjust the position here
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: colorWhite),
          height: 100,
          padding: const EdgeInsets.all(8),
          child: FloatingActionButton(
            onPressed: () {
              // controller.changeTabIndex(1);
              if (Homecontroller.tabController.index == 0) {
                Get.toNamed(RouteName.mapTracking);
              } else {
                Get.toNamed(RouteName.expense);
              }
              // print("ini bukan");
            },
            child: Icon(Icons.add, size: 28),
            backgroundColor: colorPrimary,
            elevation: 6,
            shape: const CircleBorder(),
          ),
        ),
      ),
    );
  }
}
