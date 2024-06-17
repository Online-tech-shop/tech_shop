import 'package:flutter/material.dart';
import 'package:tech_shop/models/filtr_model.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/models/review_model.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/viewmodels/review_view_model.dart';

class FilterScreen extends StatefulWidget {
  HomeViewModel homeViewModel;
  FilterScreen({
    required this.homeViewModel,
    super.key,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _reviewViewModel = ReviewViewModel();
  List<Product> products = [];
  List<Review> reviewList = [];

  @override
  void initState() {
    loadProductsAndReviews();
    super.initState();
  }

  void loadProductsAndReviews() async {
    try {
      List<Product> fetchedProducts =
          await widget.homeViewModel.onCarouselItemTap();
      List<Review> fetchedReviews = await _reviewViewModel.getReviews();
      setState(() {
        products = fetchedProducts;
        reviewList = fetchedReviews;
      });
    } catch (e) {
      // setState(() {});
    }
  }

  List<Product> arzonroq() {
    products.sort(
      (a, b) {
        return a.price.compareTo(b.price);
      },
    );
    setState(() {});
    return products;
  }

  List<Product> qimmatroq() {
    products.sort(
      (a, b) => b.price.compareTo(a.price),
    );
    setState(() {});
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtr"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filtrList.length,
              itemBuilder: (context, index) {
                final data = filtrList[index];
                return ListTile(
                  title: Text(data.title),
                  onTap: () {
                    setState(() {
                      for (var item in filtrList) {
                        item.isSelected = false;
                      }

                      widget.homeViewModel.products =
                          index == 0 ? arzonroq() : qimmatroq();
                      for (var i in widget.homeViewModel.products) {
                        print(i.price);
                      }
                      data.isSelected = true;
                    });
                  },
                  trailing: data.isSelected
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
