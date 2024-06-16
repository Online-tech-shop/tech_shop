import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/viewmodels/review_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_card.dart';

class ShowProductsWidget extends StatefulWidget {
  final HomeViewModel viewModel;
  final String searchText;
  final int? categoryIndex;

  ShowProductsWidget({
    super.key,
    required this.viewModel,
    required this.searchText,
    this.categoryIndex,
  });

  @override
  State<ShowProductsWidget> createState() => _ShowProductsWidgetState();
}

class _ShowProductsWidgetState extends State<ShowProductsWidget> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  final ReviewViewModel _reviewViewModel = ReviewViewModel();

  List<Product> products = [];
  List<Review> reviewList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProductsAndReviews();
  }

  void loadProductsAndReviews() async {
    try {
      List<Product> fetchedProducts = await _homeViewModel.onCarouselItemTap();
      List<Review> fetchedReviews = await _reviewViewModel.getReviews();
      setState(() {
        products = fetchedProducts;
        reviewList = fetchedReviews;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    List<Product> filteredProducts = products.where((product) {
      bool matchesCategory = widget.categoryIndex == null ||
          product.category == widget.categoryIndex;
      bool matchesSearchText = product.name[0]
          .toLowerCase()
          .contains(widget.searchText.toLowerCase());
      return matchesCategory && matchesSearchText;
    }).toList();

    return filteredProducts.isEmpty
        ? const Center(
            child: Text("Mahsulot topilmadi"),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 370,
              crossAxisCount: 2,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: filteredProducts[index],
                reviews: filteredProducts[index].getReviews(reviewList),
              );
            },
          );
  }
}
