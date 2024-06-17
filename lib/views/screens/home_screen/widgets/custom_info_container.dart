import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/utils/functions.dart';

class CustomInfoContainer extends StatelessWidget {
  final int? reviewCount;
  final double? reviewAverageNumber;
  final Product product;
  final bool isSelected;

  const CustomInfoContainer({
    super.key,
    this.reviewCount,
    this.reviewAverageNumber,
    required this.isSelected,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(
        right: isSelected ? 10 : 0,
        left: isSelected ? 0 : 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isSelected ? '$reviewAverageNumber' : '${product.orderAmount}+',
                style: TextStyle(
                  color: CustomFunctions.isLight(context)
                      ? Colors.grey.withOpacity(0.8)
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(5),
              if (isSelected)
                for (int i = 0; i < 5; i++)
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
            ],
          ),
          const Gap(5),
          Text(
            isSelected
                ? reviewCount == 0
                    ? 'Baholar hali yoʻq'
                    : '$reviewCount sharh'
                : product.orderAmount == 0
                    ? 'Buyurtma yoʻq '
                    : 'ta buyurtma',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color:
                  CustomFunctions.isLight(context) ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
