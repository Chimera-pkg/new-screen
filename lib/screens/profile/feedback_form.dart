import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/button.dart';

class FeedbackForm extends StatelessWidget {
  const FeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Feedback',
              style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 24,
                  fontWeight: bold,
                  color: colorBlack),
            ),
            const SizedBox(height: 8),
            Text(
              'Please provide your detailed company information. (* Required)',
              style: TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 16,
                fontWeight: medium,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 16),
            Container(
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
              padding: const EdgeInsets.all(8),
              child: const TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Send your feedback / feature request',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Button(
              height: 6.h,
              width: 100.w,
              onTap: () {},
              colorBg: colorNavy,
              label: "Submit",
              textColor: colorWhite,
            ),
          ],
        ),
      ),
    );
  }
}
