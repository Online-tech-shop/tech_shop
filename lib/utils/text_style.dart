import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle get customUnselectedTabBoxTextStyle {
    return const TextStyle(
      color: Color(0xFF7733ff),
      fontSize: 10.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get customSelectedTabBoxTextStyle {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 10.0,
      fontWeight: FontWeight.w600,
    );
  }
}
