import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle get customUnselectedTabBoxTextStyle {
    return TextStyle(
      color: const Color(0xFF7733ff),
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
