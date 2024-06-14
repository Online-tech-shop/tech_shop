import 'package:flutter/cupertino.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/home_screen/views/view_product_screen.dart';

class RouteName {
  static const String viewProduct = '/viewProduct';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.viewProduct:
      final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
      return CupertinoPageRoute(
        builder: (BuildContext context) =>
            ViewProductScreen(product: data['product'] as Product),
      );
    default:
      return CupertinoPageRoute(
        builder: (BuildContext context) => MainScreen(),
      );
  }
}
