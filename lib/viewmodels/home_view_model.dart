import 'package:flutter/material.dart';
import 'package:tech_shop/models/carouse_item.dart';
import 'package:tech_shop/models/category_item.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/service/product_http_service.dart';

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
  ProductHttpService _httpService = ProductHttpService();
  // final List<Product> productItems = List.generate(
  //   20,
  //   (index) => Product(

  //     // 'assets/images/product.png',
  //     // 'Kir yuvish mashinasi JPE Invertor BLDC, 6-8 kg, kechiktirib yuvish, Child-Lock, ko\'pikni olib tashlash',
  //     // '58 387 so\'m /oyiga',
  //     // '519 000 so\'m',
  //     // '611 000 so\'m',
  //   ),
  // );

  Future<List<Product>> onCarouselItemTap() async {
    return await _httpService.getProducts();
  }

  void onCategoryItemTap(int index) {
    // Handle category item tap
  }
}
