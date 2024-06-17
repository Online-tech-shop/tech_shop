import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/utils/app_constants.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_float_action_button.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_info_container.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_user_review_box.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/favorite_button.dart';
import 'package:share_plus/share_plus.dart'; // Import the share_plus package

class ViewProductScreen extends StatefulWidget {
  final Product product;
  final List<Review> review;

  const ViewProductScreen({
    super.key,
    required this.product,
    required this.review,
  });

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _shareProduct() {
    final String productName =
        widget.product.name[AppConstants.appLanguageIndex];
    final String productUrl =
        widget.product.images.isNotEmpty ? widget.product.images[0] : '';
    final String productPrice = '${widget.product.price} ${"som".tr()}';

    Share.share(
      'Check out this product: $productName\nPrice: $productPrice\n$productUrl',
      subject: 'Product Details',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomFunctions.isLight(context)
          ? const Color(0xFFEFEFEF)
          : Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 500 - kToolbarHeight,
            pinned: true,
            backgroundColor:
                CustomFunctions.isLight(context) ? Colors.white : Colors.black,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: CustomFunctions.isLight(context)
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  children: [
                    FavoriteButton(
                      product: widget.product,
                      isSelected: false,
                      isDeleteFromFavScreen: false,
                    ),
                    const Gap(15),
                    GestureDetector(
                      onTap: _shareProduct,
                      child: const Icon(
                        CupertinoIcons.share_up,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: AnimatedOpacity(
                    opacity: top <= 110 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 70, left: 50),
                      child: Text(
                        widget.product.name[AppConstants.appLanguageIndex],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CustomFunctions.isLight(context)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  collapseMode: CollapseMode.none,
                  background: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.product.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.product.images[index],
                            height: 500 - kToolbarHeight,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 16.0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: widget.product.images.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.grey.shade600,
                              dotColor: Colors.grey.shade400,
                              dotHeight: 8.0,
                              dotWidth: 15.0,
                              spacing: 4.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: CustomFunctions.isLight(context)
                    ? Colors.white
                    : Colors.black,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name[AppConstants.appLanguageIndex],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CustomFunctions.isLight(context)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      CustomInfoContainer(
                        reviewCount: widget.review.length,
                        reviewAverageNumber:
                            CustomFunctions.countAverageOfReview(widget.review),
                        isSelected: true,
                        product: widget.product,
                      ),
                      CustomInfoContainer(
                        isSelected: false,
                        product: widget.product,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      context.tr('som',
                          namedArgs: {'narx': widget.product.price.toString()}),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: CustomFunctions.isLight(context)
                            ? Colors.black
                            : Colors.white,
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
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(

                            context.tr('dona_qoldi', namedArgs: {
                              'qoldi': widget.product.leftProduct.toString()
                            }),
                            style: TextStyle(
                              color: CustomFunctions.isLight(context)
                                  ? Colors.black
                                  : Colors.white,

                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
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
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(

                            context
                                .tr('bu_haftada_kishi_sotib_oldi', namedArgs: {
                              'boughtAmountThisWeek':
                                  widget.product.boughtAmountThisWeek.toString()
                            }),
                            style: TextStyle(
                              color: CustomFunctions.isLight(context)
                                  ? Colors.black
                                  : Colors.white,

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
                      widget.review.isNotEmpty
                          ? '${widget.review.length} ${tr('sharh')}'
                          : tr('ushbu_mahsulotga_hali_sharh_yozilmagan'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.review.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CustomUserReviewBox(
                    index: index,
                    review: widget.review[index],
                  );
                },
                childCount: widget.review.length,
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomFloatActionButton(product: widget.product),
    );
  }
}
