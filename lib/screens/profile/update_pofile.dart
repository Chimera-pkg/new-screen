import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/profile_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';

class UpdatePofileIndividual extends StatelessWidget {
  UpdatePofileIndividual({super.key});

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
      ),
      backgroundColor: colorPrimary,
      body: SingleChildScrollView(
        child: Padding(
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
                'Profile detail',
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 24,
                    fontWeight: bold,
                    color: colorBlack),
              ),
              SizedBox(height: 8.0),
              Text(
                'Please Provide your detailed information. (* Required)',
                style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 16,
                  fontWeight: medium,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Name*",
                inputController: profileController.individualNameTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Address",
                inputController:
                    profileController.individualAddressTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputNumberTextField(
                label: "Zip Code",
                inputController:
                    profileController.individualZipCodeTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Email*",
                inputController:
                    profileController.individualEmailTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputNumberTextField(
                label: "Phone",
                inputController:
                    profileController.individualPhoneTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Website",
                inputController:
                    profileController.individualWebsiteTextController,
              ),
              SizedBox(
                height: 5.h,
              ),
              Button(
                height: 6.h,
                width: 100.w,
                onTap: () {},
                colorBg: colorNavy,
                label: " Update",
                textColor: colorWhite,
              ),
              SizedBox(
                height: 1.5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdatePofileCompany extends StatelessWidget {
  UpdatePofileCompany({super.key});

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                'Company Details',
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 24,
                    fontWeight: bold,
                    color: colorBlack),
              ),
              SizedBox(height: 8.0),
              Text(
                'Please Provide your detailed information. (* Required)',
                style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 16,
                  fontWeight: medium,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Company Name*",
                inputController: profileController.companyNameTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Address",
                inputController: profileController.companyAddressTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputNumberTextField(
                label: "Zip Code",
                inputController: profileController.companyZipCodeTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Company Email*",
                inputController: profileController.companyEmailTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputNumberTextField(
                label: "Company Phone",
                inputController: profileController.companyPhoneTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Website",
                inputController: profileController.companyWebsiteTextController,
              ),
              SizedBox(
                height: 5.h,
              ),
              Button(
                height: 6.h,
                width: 100.w,
                onTap: () {},
                colorBg: colorNavy,
                label: " Update",
                textColor: colorWhite,
              ),
              SizedBox(
                height: 1.5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
