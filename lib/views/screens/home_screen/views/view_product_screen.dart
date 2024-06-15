import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/utils/app_constants.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_float_action_button.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_info_container.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_user_review_box.dart';

class ViewProductScreen extends StatelessWidget {
  final Product product;
  final List<Review> review;

  const ViewProductScreen({
    super.key,
    required this.product,
    required this.review,
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFEFEFEF),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.heart,
                  ),
                ),
                const Gap(15),
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.share_up,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                product.images.length,
                (int index) => Image.network(
                  product.images[index],
                  height: 500 - kToolbarHeight,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name[AppConstants.appLanguageIndex],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    CustomInfoContainer(
                      reviewCount: review.length,
                      reviewAverageNumber: CustomFunctions.countAverageOfReview(review),
                      isSelected: true,
                      product: product,
                    ),
                    CustomInfoContainer(
                      isSelected: false,
                      product: product,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    '${product.price} so\'m',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6F5DE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.check),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "${product.leftProduct} dona qoldi",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEFD0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.shopping_cart_outlined),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Bu haftada ${product.boughtAmountThisWeek} kishi sotib oldi",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    review.isNotEmpty
                        ? '${review.length} sharh'
                        : "Ushbu mahsulotga hali sharh yozilmagan",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (review.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: review.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CustomUserReviewBox(
                      index: index,
                      review: review[index],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: kToolbarHeight + 10)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatActionButton(product: product),
    );
  }
}
