import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/viewmodels/review_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_card.dart';

class ProductGrid extends StatefulWidget {
  final HomeViewModel viewModel;

  const ProductGrid({super.key, required this.viewModel});

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
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.hasError) {
          return const Center(
            child: Text('error: snapshot!'),
          );
        } else {
          List<Product> products = snapshot.data['product'];
          List<Review> reviewList = snapshot.data['review'];
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
