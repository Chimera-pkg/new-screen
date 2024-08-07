import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/auth_controller.dart';
import 'package:skribex_app/controllers/profile_controller.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // final controllerProfile = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controllerProfile) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: colorPrimary,
                title: Center(
                  child: controllerProfile.token == "company"
                      ? title("My Company")
                      : title("My Profile"),
                ),
              ),
              backgroundColor: colorPrimary,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileHeader(photoProfile: "assets/images/running.jpeg"),
                  Padding(
                    padding: const EdgeInsets.all(defaultBorderRadius2),
                    child: Text(
                      "Accoount",
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 14,
                          fontWeight: medium,
                          color: colorBlack),
                    ),
                  ),
                  profileContent(
                      icon: "assets/icons/my-profile.svg",
                      color: colorLightBlue,
                      label: "My Profile",
                      iconArrow: Icons.arrow_forward_ios_outlined,
                      onTap: () {
                        controllerProfile.token == "company"
                            ? Get.toNamed(RouteName.updateProfileCompany)
                            : Get.toNamed(RouteName.updateProfileIndividual);
                      }),
                  Padding(
                    padding: const EdgeInsets.all(defaultBorderRadius2),
                    child: Text(
                      "Other",
                      style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 14,
                          fontWeight: medium,
                          color: colorBlack),
                    ),
                  ),
                  profileContent(
                      icon: "assets/icons/faq.svg",
                      color: colorLightBlue,
                      label: "FAQ",
                      iconArrow: Icons.arrow_forward_ios_outlined,
                      onTap: () {}),
                  profileContent(
                      icon: "assets/icons/terms-condition.svg",
                      color: colorLightBlue,
                      label: "Terms & Conditions",
                      iconArrow: Icons.arrow_forward_ios_outlined,
                      onTap: () {}),
                  profileContent(
                      icon: "assets/icons/privacy.svg",
                      color: colorLightBlue,
                      label: "Privacy Policy",
                      iconArrow: Icons.arrow_forward_ios_outlined,
                      onTap: () {}),
                  profileContent(
                      icon: "assets/icons/customer-services.svg",
                      color: colorLightBlue,
                      label: "Customer Services",
                      iconArrow: Icons.arrow_forward_ios_outlined,
                      onTap: () {}),
                  profileContent(
                      icon: "assets/icons/customer-services.svg",
                      color: colorLightBlue,
                      label: "Feedback Form",
                      iconArrow: Icons.arrow_forward_ios_outlined,
                      onTap: () {
                        Get.toNamed(RouteName.feedbackForm);
                      }),
                  // const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultBorderRadius),
                    child: profileContent(
                        icon: "assets/icons/logout.svg",
                        color: colorLightRed,
                        label: "Logout",
                        labelColor: colorDarkRed,
                        onTap: () {
                          controllerProfile.onSignOut();
                        }),
                  ),
                ],
              ),
            ),
            if (controllerProfile.isLoading.value)
              ModalBarrier(
                color: Colors.black54,
                dismissible: false,
              ),
            Visibility(
              child: Center(
                  child: GestureDetector(
                      onTap: () {
                        controllerProfile.isLoading.value = false;
                      },
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: colorPrimary, size: 30))),
              visible: controllerProfile.isLoading.value,
            )
          ],
        );
      },
    );
  }

  Widget title(String title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: 'MonaSans',
          fontSize: 14,
          fontWeight: medium,
          color: colorBlack),
    );
  }

  Widget profileHeader({Key? key, required String photoProfile}) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultBorderRadius2, vertical: defaultBorderRadius),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipOval(
                  child: Image.asset(
                    photoProfile,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "Nama",
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 14,
                    fontWeight: medium,
                    color: colorBlack),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileContent(
      {Key? key,
      required String icon,
      required Color color,
      required String label,
      required Function()? onTap,
      Color? labelColor,
      IconData? iconArrow}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultBorderRadius2, vertical: defaultBorderRadius),
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100), color: color),
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    icon,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 12,
                      fontWeight: regular,
                      color: labelColor ?? null),
                ),
              ],
            ),
            iconArrow != null
                ? const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: colorDarkBlue,
                    size: 20,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
