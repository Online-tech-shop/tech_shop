import 'package:flutter/material.dart';
import 'package:tech_shop/utils/text_style.dart';

class CustomTabBoxButton extends StatelessWidget {
  final String buttonText;
  final String? imagePath;
  final IconData? icon;
  final int currentIndex;
  final bool isSelected;
  final Function(int) onTabBoxPressed;

  const CustomTabBoxButton({
    super.key,
    required this.buttonText,
    this.imagePath,
    this.icon,
    required this.currentIndex,
    required this.isSelected,
    required this.onTabBoxPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabBoxPressed(currentIndex),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null)
                Image.asset(
                  imagePath!,
                  height: 27,
                  width: 27,
                )
              else
                Icon(
                  icon,
                  color: isSelected ? const Color(0xFF7733ff) : Colors.white,
                ),
              Text(
                buttonText,
                style: isSelected
                    ? CustomTextStyle.customUnselectedTabBoxTextStyle
                    : CustomTextStyle.customSelectedTabBoxTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
