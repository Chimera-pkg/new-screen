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

class ClientScreen extends StatelessWidget {
  ClientScreen({super.key});

  final controller = Get.find<ClientController>();

  final List<String> _trips = ["Trip 1", "Trip 2", "Trip 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Client",
          style: TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 14,
              fontWeight: medium,
              color: colorSecondary),
        )),
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
      body: Padding(
        padding: const EdgeInsets.all(defaultBorderRadius2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount*',
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 13,
                    fontWeight: bold,
                    color: colorSecondary),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: colorBackground,
                  // gradient: LinearGradient(
                  //   colors: [Colors.white, colorGrey],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Description*',
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 13,
                    fontWeight: bold,
                    color: colorSecondary),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: colorBackground,
                  // gradient: LinearGradient(
                  //   colors: [Colors.white, colorGrey],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Add Receipt*',
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 13,
                    fontWeight: bold,
                    color: colorSecondary),
              ),
              SizedBox(height: 8.0),
              GetBuilder<ClientController>(
                builder: (controller) => controller.imageFile == null
                    ? GestureDetector(
                        onTap: controller.pickImage,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(12.0),
                            color: colorBackground,
                            // gradient: LinearGradient(
                            //   colors: [Colors.white, colorGrey],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/icons/upload-image.png"),
                                Text("Choose form galery or Take a Photo"),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image.file(File(controller.imageFile!.path)),
                      ),
              ),
              SizedBox(height: 15),
              Text(
                "Add expense to trip",
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 13,
                    fontWeight: bold,
                    color: colorSecondary),
              ),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: colorBackground,
                  // gradient: LinearGradient(
                  //   colors: [Colors.white, colorGrey],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GetBuilder<ClientController>(
                  builder: (controller) => Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text("Choose Trip"),
                          value: controller.selectedTrip,
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (String? newValue) {
                            controller.chooseTrip(newValue);
                          },
                          items: _trips
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Button(
                height: 6.h,
                width: 100.w,
                onTap: () {
                  controller.submitExpense();
                },
                colorBg: colorNavy,
                label: "Send",
                textColor: colorWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
