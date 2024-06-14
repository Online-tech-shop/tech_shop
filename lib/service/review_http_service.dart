import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_shop/models/review_model.dart';

class ReviewHttpService {
  final Uri _url = Uri.parse(
    'https://to-do-f5021-default-rtdb.firebaseio.com/review.json',
  );

  Future<List<Review>> getReviews() async {
    try {
      final http.Response response = await http.get(_url);
      if (response.statusCode == 200) {
        if (response.body == 'null') {
          return [];
        }
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<Review> loadedReviews = [];

        data.forEach(
          (String key, dynamic value) {
            value['review-id'] = key;
            loadedReviews.add(Review.fromJson(value));
          },
        );

        return loadedReviews;
      }
      throw 'error: ReviewHttpService().loadedReviews()';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addReview() async {
    await http.post(
      _url,
      body: jsonEncode(
        {
          'product-id': '-O-GR_LHLM1mDEDv8wba',
          'user-name': 'gishmat',
          'text': 'text',
          'star': 2,
          'published-date-time': 'yesterday',
        },
      ),
    );
  }
}
