import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';

class CustomInfoContainer extends StatelessWidget {
  final Product product;
  final bool isSelected;

  const CustomInfoContainer({
    super.key,
    required this.isSelected,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(
        right: isSelected ? 0 : 10,
        left: isSelected ? 10 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.yellow,
      ),
      child: Column(
        children: [
          Text('5')
        ],
      ),
    );
  }
}
