import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/controllers/invite_employee_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';
import 'package:skribex_app/widgets/form_input_textfield.dart';

class InviteTeam extends StatelessWidget {
  InviteTeam({super.key});

  final controller = Get.find<InviteEmployeeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite your team members',
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 24,
                      fontWeight: bold,
                      color: colorBlack),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'You can send five invites at a time',
                  style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 16,
                      fontWeight: regular,
                      color: Colors.blueGrey[800]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder<InviteEmployeeController>(
                            builder: (controller) {
                              controller.emailController
                                  .add(TextEditingController());
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.emailFieldCount,
                                itemBuilder: (context, index) {
                                  return emailField(index);
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          GetBuilder<InviteEmployeeController>(
                              builder: (controller) {
                            if (controller.emailFieldCount < 5) {
                              return GestureDetector(
                                onTap: () {
                                  controller.incrementEmailField();
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const LinearGradient(
                                            colors: [Colors.white, colorGrey],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.add,
                                          color: colorDarkGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Invite More",
                                        style: TextStyle(
                                            fontFamily: 'MonaSans',
                                            fontSize: 13,
                                            fontWeight: regular,
                                            color: colorDarkGrey),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Button(
                        height: 6.h,
                        width: 100.w,
                        onTap: () {},
                        colorBg: colorNavy,
                        label: " Submit",
                        textColor: colorWhite,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget emailField(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.5.h,
        ),
        FormInputTextField(
          label: "Email Address",
          inputController: controller.emailController[index],
        ),
      ],
    );
  }
}
