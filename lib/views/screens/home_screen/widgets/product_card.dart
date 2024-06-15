import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/models/sql_model.dart';
import 'package:tech_shop/utils/app_constants.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/utils/routes.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final List<Review> reviews;

  const ProductCard({
    super.key,
    required this.product,
    required this.reviews,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteName.viewProduct,
          arguments: {
            'product': widget.product,
            'review': widget.product.getReviews(widget.reviews)
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  widget.product.images[0],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name[AppConstants.appLanguageIndex],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0XffFFB740),
                      size: 15,
                    ),
                    Text(
                      ' ${CustomFunctions.countAverageOfReview(widget.reviews).toString().substring(0, 3)} ',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "(${widget.reviews.length}ta sharhlar)",
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.product.price} so\'m',
                      style: const TextStyle(
                        decorationThickness: 2,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final save = Save(
                          title: widget.product.name[0],
                          image: widget.product.images[0],
                          price: widget.product.price.toString(),
                          amount: widget.product.leftProduct.toString(),
                          seller: widget.product.seller,
                          brieflyAboutProduct:
                              widget.product.brieflyAboutProduct[0],
                        );
                        Provider.of<SaveViewModel>(context, listen: false)
                            .addSave(save);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: SvgPicture.asset(
                            'assets/icons/product_icons/cart.svg'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
