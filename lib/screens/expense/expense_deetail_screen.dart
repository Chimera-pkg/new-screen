import 'package:flutter/material.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class ExpenseDetailScreen extends StatelessWidget {
  const ExpenseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Expense Detail",
            style: TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 14,
                fontWeight: medium,
                color: colorSecondary),
          ),
        ),
        backgroundColor: colorBackground,
      ),
      backgroundColor: colorBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Image.asset("assets/images/running.jpeg"),
            SizedBox(
              height: 10,
            ),
            Text(
              "160",
              style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 18,
                  fontWeight: bold,
                  color: colorBlack),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Monday  14 - 05 - 2024",
              style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 12,
                  fontWeight: bold,
                  color: colorDarkGrey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lorem ipsum dolor sit amet consectetur. Tortor montes tristique nec dis egestas in id ullamcorper et. Amet commodo vitae morbi odio eu et amet arcu. Lectus eleifend netus pharetra tristique pellentesque nibh viverra a bibendum. Montes et enim semper orci varius iaculis suspendisse.",
              style: TextStyle(
                  fontFamily: 'MonaSans',
                  fontSize: 12,
                  fontWeight: bold,
                  color: colorSecondary),
            )
          ],
        ),
      ),
    );
  }
}
