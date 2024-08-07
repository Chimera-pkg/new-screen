import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:get/get.dart';

class FormPasswordTextField extends StatelessWidget {
  FormPasswordTextField(
      {super.key,
      required this.passwordController,
      required this.isObsecured,
      required this.label});

  final TextEditingController passwordController;
  final RxBool isObsecured;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 13,
              fontWeight: bold,
              color: colorNavy),
        ),
        const SizedBox(height: 8.0),
        Container(
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
          child: Obx(
            () => TextField(
              obscureText: isObsecured.value,
              controller: passwordController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => isObsecured.value = !isObsecured.value,
                    icon: Icon(isObsecured.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: colorDarkGrey,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
