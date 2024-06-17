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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    review.publishedDateTime,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    color: review.star > index
                        ? const Color(0xFFFFB536)
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          Text(review.text),
        ],
      ),
    );
  }
}
