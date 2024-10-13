import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color primaryBlue = Color(0xff4078bc);
  static const Color primaryOrange = Color(0xffF46F22);
  static const Color secondaryBlue = Color(0xff4B68FF);
  static const Color buttonGreen = Color(0xff0EAB00);

  //text Colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff6C757D);
  static const Color textWhite = Colors.white;

  //Background Color
  static const Color light = Color(0xffF6F6F6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xffF3F5FF);

  //Background Container Color
  static const Color lightContainer = Color(0xffF6F6F6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  //Button Color
  static const Color buttonPrimary = Color(0xff01ad7d);
  static const Color buttonSecondary = Color(0xfff4f5f7);
  static const Color buttonDisable = Color(0xffc4c4c4);

  //Border Color
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  //error and validate color
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

  static const Color neutral100 = Color(0xffF0F0F0);
  static const Color neutral200 = Color(0xffDEDEDE);
  static const Color neutral300 = Color(0xffA7A4A4);
  static const Color neutral400 = Color(0xff65636F);
  static const Color neutral500 = Color(0xff383846);
  static const Color neutral600 = Color(0xff2D2C3B);
  static const Color neutral700 = Color(0xff242332);
  static const Color neutral800 = Color(0xff1B1A28);
  static const Color neutral900 = Color(0xff171423);
  static const Color neutralBlack = Color(0xff120E21);

  static const Color primaryGreen100 = Color(0xffD1FEDC);
  static const Color primaryGreen500 = Color(0xff1AF7A9);
  static const Color primaryGreen600 = Color(0xff13D4A3);
  static const Color primaryGreen700 = Color(0xff0DB198);
  static const Color primaryGreen900 = Color(0xff047176);

  // static LinearGradient customLineGradientGreen = const LinearGradient(colors: [
  //   primaryBlue500,
  //   primaryGreen500,
  // ]);
  static LinearGradient customLineGradientBlack = const LinearGradient(colors: [
    Color(0xff1D1C2B),
    Color(0xff2C2B3D),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static LinearGradient customLineGradientButton =
      const LinearGradient(colors: [
    Color(0xff4078bc),
    Color.fromARGB(255, 217, 216, 227),
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static LinearGradient customLineGradientLine = const LinearGradient(colors: [
    Color.fromARGB(255, 170, 185, 251),
    Color(0xfff4f8fb),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
