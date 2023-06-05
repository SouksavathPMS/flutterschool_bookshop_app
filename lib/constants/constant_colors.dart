import 'package:flutter/material.dart';

class ConstantColor {
  static const Color primaryColor = Color(0xffDC6E55);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xff6D6D6D);
  static const Color darkGrey = Color(0xff494949);
  static const MaterialColor mainColor = MaterialColor(
    0xffDC6E55, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffCDE8DF),
      100: Color(0xffCDE8DF),
      200: Color(0xffCDE8DF),
      300: Color(0xffCDE8DF),
      400: Color(0xffCDE8DF),
      500: Color(0xffCDE8DF),
      600: Color(0xffCDE8DF),
      700: Color(0xffCDE8DF),
      800: Color(0xffCDE8DF),
      900: Color(0xffCDE8DF), //10%
    },
  );
}
