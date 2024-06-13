import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/service/product_http_service.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_widget.dart';

class FavoriteProducts extends StatefulWidget {
  const FavoriteProducts({super.key});

  @override
  State<FavoriteProducts> createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  final productHttpServices = ProductHttpService();
  final HomeViewModel viewModel = HomeViewModel();

  Future<List<Product>> getProducts() async {
    return await viewModel.getFavouriteProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Istaklarim"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: productHttpServices.getFavoriteProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final product = snapshot.data;

          return product == null || product.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/favorites.png",
                        width: 250,
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text(
                              "Buyerda sevimli tovarlaringizni saqlab qo'aymiz",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                                height: 10), // Add spacing between the texts
                            Text(
                              "Odatda buyurtma qiladigan yoki keyinroq sotib olishni istagan tovarlarda ♡ belgisini bosing",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : ProductGrid(products: getProducts());
        },
      ),
    );
  }
}
