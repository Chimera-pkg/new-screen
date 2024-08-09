// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/to_do_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/date_time.dart';
// import 'package:skribex_app/widgets/date_picker.dart';
// import 'package:skribex_app/widgets/date_time.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class ToDoScreen extends StatelessWidget {
  ToDoScreen({super.key});

  final controller = Get.find<ToDoController>();

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
                'New Task ToDo',
                style: TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 24,
                    fontWeight: bold,
                    color: colorBlack),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Title Task*",
                inputController: controller.nameTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              FormInputTextField(
                label: "Description",
                inputController: controller.addressTextController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Obx(
                () => DateTime(
                  label: "Date",
                  valueText: controller.isChekTime.value == true
                      ? DateFormat('dd MMMM yyyy - HH:mm')
                          .format(controller.tanggal)
                      : "",
                  valueStyle: TextStyle(
                    color: controller.isChekTime.value == true
                        ? colorBlack
                        : colorPrimary,
                  ),
                  onPressed: () {
                    controller.dateTimePicker(context);
                  },
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Button(
                height: 6.h,
                width: 100.w,
                onTap: () {},
                colorBg: colorNavy,
                label: " Create",
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
