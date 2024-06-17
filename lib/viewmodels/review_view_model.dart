import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/service/review_http_service.dart';

class ReviewViewModel {
  final ReviewHttpService _reviewHttpService = ReviewHttpService();

  Future<List<Review>> getReviews() async {
    try {
      return await _reviewHttpService.getReviews();
    } catch (e) {
      rethrow;
    }
  }
}
