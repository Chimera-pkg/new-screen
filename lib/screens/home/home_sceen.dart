import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/home_controller.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/icons/tiktraq.png",
          height: 40,
        ),
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultBorderRadius2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: colorPastelYellow,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
                height: 10.h,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Saving Summary",
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 14,
                          fontWeight: bold,
                          color: colorBlack),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ 15,75",
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 13,
                          fontWeight: regular,
                          color: colorDarkGrey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 21.h,
            width: double.infinity,
            child: Column(
              children: [
                GetBuilder<HomeController>(
                    // init: HomeController(),
                    builder: (controller) {
                  return Expanded(
                    child: PageView(
                      controller: PageController(
                        initialPage: controller.selectedIndex.value,
                      ),
                      onPageChanged: (int index) {
                        controller.changePage(index);
                      },
                      children: <Widget>[
                        _buildItemPage("assets/icons/map.svg",
                            "Total Miles Driven", "13.9 Km"),
                        _buildItemPage(
                            "assets/icons/map.svg", "Total Expense", "160\$"),
                        _buildItemPage(
                            "assets/icons/person.svg", "Total Clients", "10"),
                        _buildItemPage(
                            "assets/icons/map.svg", "To Do List", "3/5"),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildIndicator(0, controller.selectedIndex.value),
                            _buildIndicator(1, controller.selectedIndex.value),
                            _buildIndicator(2, controller.selectedIndex.value),
                            _buildIndicator(3, controller.selectedIndex.value),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            // height: 40.h,
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: <Widget>[
                      Column(
                        children: [
                          homeTabTripsContent(),
                          homeTabTripsContent(),
                          homeTabTripsContent(),
                        ],
                      ),
                      Column(
                        children: [
                          homeTabExpenseContent(),
                          homeTabExpenseContent(),
                          homeTabExpenseContent(),
                        ],
                      ),
                      Column(
                        children: [
                          homeTabClientContent(),
                          homeTabClientContent(),
                          homeTabClientContent(),
                        ],
                      ),
                      Column(
                        children: [
                          homeTabToDoContent(),
                          homeTabToDoContent(),
                          homeTabToDoContent(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemPage(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: defaultBorderRadius2, horizontal: defaultBorderRadius2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: colorPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon),
              const SizedBox(
                height: 8,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  label,
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 14,
                      fontWeight: regular,
                      color: colorDarkGrey),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 13,
                      fontWeight: bold,
                      color: colorBlack),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(int index, int selectedIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: selectedIndex == index ? 12.0 : 8.0,
      height: selectedIndex == index ? 12.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: selectedIndex == index ? colorWhite : colorGrey,
        gradient: selectedIndex == index
            ? const LinearGradient(
                colors: [Colors.white, colorDarkGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Colors.white, colorGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }

  Widget homeTabTripsContent() {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultBorderRadius,
          left: defaultBorderRadius2,
          right: defaultBorderRadius2),
      child: Container(
        height: 7.5.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: colorPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/map.svg"),
                  SizedBox(width: 3.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "50 Minutes",
                        style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 14,
                            fontWeight: regular,
                            color: colorDarkGrey),
                      ),
                      Text(
                        "23 Feb 2023 - 05:00 AM",
                        style: TextStyle(
                            fontFamily: 'MonaSans',
                            fontSize: 10,
                            fontWeight: light,
                            color: colorDarkGrey),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                "13.9 km",
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 13,
                    fontWeight: bold,
                    color: colorBlack),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget homeTabExpenseContent() {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultBorderRadius,
          left: defaultBorderRadius2,
          right: defaultBorderRadius2),
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            Get.toNamed(RouteName.expenseDetail);
          },
          child: Container(
            height: 7.5.h,
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/dollar.svg",
                        color: colorDarkGrey,
                        height: 5.5.w,
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lunch With Client",
                            style: TextStyle(
                                fontFamily: 'MonaSans',
                                fontSize: 14,
                                fontWeight: regular,
                                color: colorDarkGrey),
                          ),
                          // Text(
                          //   "160\$",
                          //   style: TextStyle(
                          //       fontFamily: 'MonaSans',
                          //       fontSize: 10,
                          //       fontWeight: light,
                          //       color: colorDarkGrey),
                          // )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "160\$",
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 13,
                        fontWeight: bold,
                        color: colorBlack),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget homeTabClientContent() {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultBorderRadius,
          left: defaultBorderRadius2,
          right: defaultBorderRadius2),
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            Get.toNamed(RouteName.clientForm);
          },
          child: Container(
            height: 7.5.h,
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/person.svg",
                        color: colorDarkGrey,
                        height: 5.5.w,
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Client Meeting",
                            style: TextStyle(
                                fontFamily: 'MonaSans',
                                fontSize: 14,
                                fontWeight: regular,
                                color: colorDarkGrey),
                          ),
                          Text(
                            "160\$",
                            style: TextStyle(
                                fontFamily: 'MonaSans',
                                fontSize: 10,
                                fontWeight: light,
                                color: colorDarkGrey),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "23 Feb 2023 2:05 PM",
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 13,
                        fontWeight: bold,
                        color: colorBlack),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget homeTabToDoContent() {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultBorderRadius,
          left: defaultBorderRadius2,
          right: defaultBorderRadius2),
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            Get.toNamed(RouteName.expenseDetail);
          },
          child: Container(
            height: 7.5.h,
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultBorderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/dollar.svg",
                        color: colorDarkGrey,
                        height: 5.5.w,
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Client Meeting",
                            style: TextStyle(
                                fontFamily: 'MonaSans',
                                fontSize: 14,
                                fontWeight: regular,
                                color: colorDarkGrey),
                          ),
                          Text(
                            "160\$",
                            style: TextStyle(
                                fontFamily: 'MonaSans',
                                fontSize: 10,
                                fontWeight: light,
                                color: colorDarkGrey),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "23 Feb 2023 2:05 PM",
                    style: TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 13,
                        fontWeight: bold,
                        color: colorBlack),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
