import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle {
  static TextStyle get customUnselectedTabBoxTextStyle {
    return TextStyle(
      color: const Color(0xFF7733ff),
      fontSize: 10.0.sp,
      fontWeight: FontWeight.w600,
    );
  }
  static TextStyle get customSelectedTabBoxTextStyle {
    return TextStyle(
      color: Colors.grey,
      fontSize: 10.0.sp,
      fontWeight: FontWeight.w600,
    );
  }
}
