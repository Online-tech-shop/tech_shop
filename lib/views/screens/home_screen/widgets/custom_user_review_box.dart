import 'package:flutter/material.dart';
import 'package:tech_shop/models/review_model.dart';

class CustomUserReviewBox extends StatelessWidget {
  final int index;
  final Review review;

  const CustomUserReviewBox({
    super.key,
    required this.index,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        // color: Colors.,
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: review.star > index ? Colors.yellow : Colors.grey,
              ),
            ),
          ),
          Text(review.text),
        ],
      ),
    );
  }
}
