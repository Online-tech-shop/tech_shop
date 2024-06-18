import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/review_model.dart';

class CustomFunctions {
  static double countAverageOfReview(List<Review> listReview) {
    if (listReview.isEmpty) {
      return 0.0;
    }
    int sumOfReview = 0;
    for (var each in listReview) {
      sumOfReview += each.star;
    }
    double average = sumOfReview / listReview.length;
    return average;
  }

  static bool isLight(BuildContext context) {
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light) {
      return true;
    } else {
      return false;
    }
  }

  static bool isUzbek(BuildContext context) {
    final Locale currentLocale = context.locale;
    String languageCode = currentLocale.languageCode;
    if (languageCode == 'uz') {
      return true;
    }
    return false;
  }

  static Future<bool> isLogged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isLogged') ?? false;
  }
}
