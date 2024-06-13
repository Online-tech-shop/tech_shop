import 'package:flutter/material.dart';
import 'package:tech_shop/models/carouse_item.dart';
import 'package:tech_shop/models/category_item.dart';
import 'package:tech_shop/models/product_item.dart';

class HomeViewModel extends ChangeNotifier {
  final List<CarouselItem> carouselItems = [
    CarouselItem('assets/images/advertise.png'),
    CarouselItem('assets/images/advertise.png'),
    CarouselItem('assets/images/advertise.png'),
  ];

  final List<CategoryItem> categoryItems = List.generate(
    20,
    (index) => CategoryItem('assets/images/category1.png', 'SSS'),
  );

  final List<ProductItem> productItems = List.generate(
    20,
    (index) => ProductItem(
      'assets/images/product.png',
      'Kir yuvish mashinasi JPE Invertor BLDC, 6-8 kg, kechiktirib yuvish, Child-Lock, ko\'pikni olib tashlash',
      '58 387 so\'m /oyiga',
      '519 000 so\'m',
      '611 000 so\'m',
    ),
  );

  void onCarouselItemTap(int index) {
    // Handle carousel item tap
  }

  void onCategoryItemTap(int index) {
    // Handle category item tap
  }
}
