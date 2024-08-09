// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';

class ToDoController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
  final TextEditingController dateTextController = TextEditingController();
  final TextEditingController timelTextController = TextEditingController();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();
  final TextEditingController zipCodeTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController websiteTextController = TextEditingController();

  final isChekTime = false.obs;
  DateTime tanggal = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> dateTimePicker(BuildContext context) {
    isChekTime.value = false;
    return DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      locale: LocaleType.id,
      onConfirm: (date) {
        print('confirm $date');
        dateTextController.text = date.toString();
        isChekTime.value = true;
        tanggal = date;
      },
      currentTime: DateTime.now(),
    );
  }
}
