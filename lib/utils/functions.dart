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
}
