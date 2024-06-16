import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/viewmodels/review_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_card.dart';

class ProductGrid extends StatefulWidget {
  final HomeViewModel viewModel;
  final bool isSelected;

  const ProductGrid({
    super.key,
    required this.viewModel,
    required this.isSelected,
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  final ReviewViewModel _reviewViewModel = ReviewViewModel();

  Future<Map<String, dynamic>> getProductsAndReview() async {
    return {
      'product': await _homeViewModel.onCarouselItemTap(),
      'review': await _reviewViewModel.getReviews(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductsAndReview(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerProductGrid();
        } else if (!snapshot.hasData || snapshot.hasError) {
          return const Center(
            child: Text('Internet bilan muammo bor.'),
          );
        } else {
          List<Product> products = widget.isSelected
              ? snapshot.data!['product']
                  .where((Product product) => product.category == 7)
                  .toList()
              : snapshot.data!['product']
                  .where((Product product) => product.category != 7)
                  .toList();

          List<Review> reviewList = snapshot.data!['review'];
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 400,
              crossAxisCount: 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                reviews: products[index].getReviews(reviewList),
              );
            },
          );
        }
      },
    );
  }
}

class ShimmerProductGrid extends StatelessWidget {
  const ShimmerProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 400,
        crossAxisCount: 2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _buildShimmerContainer(height: 230),
            const Gap(8),
            _buildShimmerContainer(height: 25),
            const Gap(8),
            _buildShimmerContainer(height: 25),
            const Gap(8),
            _buildShimmerContainer(height: 25),
          ],
        );
      },
    );
  }

  Widget _buildShimmerContainer({
    required double height,
  }) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
