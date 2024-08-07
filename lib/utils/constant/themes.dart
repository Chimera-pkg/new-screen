import 'package:flutter/material.dart';

// Colors
const Color colorWhite = Color(0xFFFCFCFC);
const Color colorGrey = Color.fromARGB(255, 219, 219, 219);
const Color colorLightGrey2 = Color(0xFF8B9EB0);
const Color colorDarkGrey = Color(0xFF878787);
const Color colorBlack = Color(0xFF2B2B2B);
const Color colorLightBlue = Color(0xffF0F7FF);
const Color colorDarkBlue = Color(0xff0165FC);
const Color colorLightRed = Color(0xffFEF5F4);
const Color colorDarkRed = Color(0xffE74C3C);
const Color colorPastelPurple = Color(0xff5E82ED);
const Color colorPastelYellow = Color(0xffF8E88B);
const Color colorPrimary = Color(0xFFE3EDF7);
const Color colorSecondary = Color(0xFF31456A);
const Color colorNavy = Color(0xFF31456A);
const Color colorBackground = Color(0xFFEBF3FA);

LinearGradient colorGradient = const LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    colorPrimary,
    colorSecondary,
  ],
);

// Font
TextStyle fontNunito = const TextStyle(fontFamily: 'Nunito');

// Font Weight
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

// Border Radius
const double defaultBorderRadius = 10.0;
const double defaultBorderRadius2 = 20.0;
const double defaultBorderRadius3 = 30.0;

// Padding
const double defaultPadding = 20.0;
