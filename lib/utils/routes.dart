import 'package:flutter/cupertino.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/home_screen/views/view_product_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_shop/views/screens/login/sign_in.dart';

class RouteName {
  static const String viewProduct = '/viewProduct';
  static const String initial = '/';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  DateTime timeBackPressed = DateTime.now();
  switch (settings.name) {
    case RouteName.viewProduct:
      final Map<String, dynamic> data =
          settings.arguments as Map<String, dynamic>;
      return CupertinoPageRoute(
        builder: (BuildContext context) => ViewProductScreen(
          product: data['product'] as Product,
          review: data['review'] as List<Review>,
        ),
      );
    case RouteName.initial:
      return CupertinoPageRoute(
        builder: (context) => const SignIn(),
      );
    default:
      return CupertinoPageRoute(
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async {
            final difference = DateTime.now().difference(timeBackPressed);
            final isExitWarning = difference >= const Duration(seconds: 2);

            timeBackPressed = DateTime.now();

            if (isExitWarning) {
              const message = "Chiqish uchun ikki marta bosing";
              Fluttertoast.showToast(msg: message, fontSize: 18);
              return false;
            } else {
              Fluttertoast.cancel();
              return true;
            }
          },
          child: const MainScreen(),
        ),
      );
  }
}
