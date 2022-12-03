import 'dart:ui';

import 'package:flutter/material.dart';

class LsColor {

  static const MaterialColor primary = MaterialColor(
    0xFF128C7E,
    <int, Color>{
      50: Color(0xFFE3F1F0),
      100: Color(0xFFB8DDD8),
      200: Color(0xFF89C6BF),
      300: Color(0xFF59AFA5),
      400: Color(0xFF369D91),
      500: Color(0xFF128C7E),
      600: Color(0xFF108476),
      700: Color(0xFF0D796B),
      800: Color(0xFF0A6F61),
      900: Color(0xFF055C4E)
    },
  );
  
  static const Color brand = Color.fromRGBO(18, 140, 126, 1);

  static const Color secondaryBrand = Color.fromRGBO(0, 103, 120, 1);

  static const Color background = Color.fromRGBO(255, 255, 255, 1);

  static const Color secondaryBackground = Color.fromRGBO(247, 248, 248, 1);

  static const Color highlightBackground = Color.fromRGBO(245, 240, 234, 1);

  static const Color transparentBackground = Color.fromRGBO(37, 37, 37, 0.64);

  static const Color label = Color.fromRGBO(38, 38, 38, 1);

  static const Color secondaryLabel = Color.fromRGBO(113, 118, 128, 1);

  static const Color lightLabel = Color.fromRGBO(149, 149, 149, 1);

  static const Color divider = Color.fromRGBO(225, 225, 225, 1);

  static const Color secondaryDivider = Color.fromRGBO(237, 237, 239, 1);

  static const Color lightDivider = Color.fromRGBO(243, 244, 246, 1);

  static const Color gray = Color.fromRGBO(186, 186, 186, 1);

  static const Color black = Color.fromRGBO(0, 0, 0, 1);

  static const Color green = Color.fromRGBO(9, 175, 111, 1);

  static const Color red = Color.fromRGBO(237, 28, 36, 1);

  static const Color yellow = Color.fromRGBO(255, 223, 139, 1);

  static const Color white = Color.fromRGBO(255, 255, 255, 1);

  static const Color successToast = Color.fromRGBO(1, 205, 116, 1);

  static const Color errorToast = Color.fromRGBO(255, 76, 76, 1);
}
