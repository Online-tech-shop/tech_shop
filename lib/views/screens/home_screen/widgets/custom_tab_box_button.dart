import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tech_shop/utils/text_style.dart';

class CustomTabBoxButton extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final int currentIndex;
  final bool isSelected;
  final Function(int) onTabBoxPressed;

  const CustomTabBoxButton({
    super.key,
    required this.buttonText,
    required this.imagePath,
    required this.currentIndex,
    required this.isSelected,
    required this.onTabBoxPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabBoxPressed(currentIndex),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            height: 27,
            width: 27,
          ),
          Text(
            buttonText,
            style: isSelected
                ? CustomTextStyle.customUnselectedTabBoxTextStyle
                : CustomTextStyle.customSelectedTabBoxTextStyle,
          ),
        ],
      ),
    );
  }
}
