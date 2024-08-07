import 'package:flutter/material.dart';

class SkribeModel {
  String name;
  String iconPath;
  Color boxColor;

  SkribeModel({
    required this.name,
    required this.iconPath,
    required this.boxColor
  });

  static List<SkribeModel> getSkirbes() {
    List<SkribeModel> skribes = [];

    skribes.add(
      SkribeModel(
          name: "Mileage",
          iconPath: 'assets/icons/speedometer-icon.svg',
          boxColor: const Color(0xff92A3FD)
      )
    );

    skribes.add(
        SkribeModel(
            name: "Expense",
            iconPath: 'assets/icons/dollar-icon.svg',
            boxColor: const Color(0xffC58BF2)
        )
    );

    return skribes;
  }
}