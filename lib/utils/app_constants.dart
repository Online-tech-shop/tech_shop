import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/user_model.dart';

class AppConstants {
  static int appLanguageIndex = 0;
  static List<Product> userCart = [];

  static Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String userSt = sharedPreferences.getString('user') ?? '';
    return User.fromJson(jsonDecode(userSt));
  }
}
