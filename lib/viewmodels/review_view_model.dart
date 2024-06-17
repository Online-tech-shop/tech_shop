import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/service/review_http_service.dart';

class ReviewViewModel {
  final ReviewHttpService _reviewHttpService = ReviewHttpService();

  List<Review> reviewsList = [];

  Future<List<Review>> getReviews() async {
    try {
      reviewsList = await _reviewHttpService.getReviews();
      return reviewsList;
    } catch (e) {
      rethrow;
    }
  }
}
