import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribex_app/controllers/auth_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class ConfirmRegisterScreen extends StatefulWidget {
  const ConfirmRegisterScreen({super.key});
  @override
  State<ConfirmRegisterScreen> createState() => _ConfirmRegisterScreenState();
}

class _ConfirmRegisterScreenState extends State<ConfirmRegisterScreen> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
      body: SingleChildScrollView(
        // child: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 300),
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.verifyCodeRegisterTextController,
                    cursorColor: colorDarkGrey,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: colorWhite,
                      hintText: "Verify Code",
                      hintStyle: TextStyle(color: colorDarkGrey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadius)),
                        borderSide: BorderSide(
                          color: colorGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadius)),
                        borderSide: BorderSide(
                          color: colorGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.verifyConfirmation();
                    },
                    elevation: 4,
                    color: colorNavy,
                    disabledColor: colorSecondary,
                    child: const Text(
                      "VERIFY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.resendCode();
                    },
                    child: const Text(
                      "Resend code",
                      style: TextStyle(color: Colors.grey),
                    ),
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
