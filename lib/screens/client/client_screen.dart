import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/client_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';

class ClientScreen extends StatelessWidget {
  ClientScreen({super.key});

  final controller = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
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
                'Client Detail',
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
                inputController: controller.nameTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Address",
                inputController: controller.addressTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputNumberTextField(
                label: "Zip Code",
                inputController: controller.zipCodeTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Company Email*",
                inputController: controller.emailTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputNumberTextField(
                label: "Phone",
                inputController: controller.phoneTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Website",
                inputController: controller.websiteTextController,
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
