import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/service/product_http_service.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';

class ProductGrid extends StatefulWidget {
  final Future<List<Product>> products;

  ProductGrid({super.key, required this.products});

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  late Future<List<Product>> _productsFuture;

  void getProducts() async {
    _productsFuture = Future.value(widget.products);
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productsFuture,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.hasError) {
          return const Center(
            child: Text('error: snapshot'),
          );
        } else {
          List<Product> products = snapshot.data;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 300, // Adjust this based on your needs
              crossAxisCount: 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final productItem = products[index];
              return ProductItemWidget(
                product: productItem,
                onFavoriteToggle: () {
                  setState(() {
                    productItem.isFavorite = !productItem.isFavorite;
                  });
                },
              );
            },
          );
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteToggle;
  final productHttpService = ProductHttpService();

  ProductItemWidget({required this.product, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                product.images[0],
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  productHttpService.addFavoriteProducts(
                      product.id,
                      product.name,
                      product.price,
                      product.category,
                      product.images,
                      product.seller,
                      product.orderAmount,
                      product.boughtAmountThisWeek,
                      product.aboutProduct,
                      product.saleType,
                      product.brieflyAboutProduct,
                      product.isFavorite);
                },
                icon: Icon(
                  product.isFavorite
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: product.isFavorite ? Colors.red : Colors.black,
                ),
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
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFFFFF00),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(product.category.toString()),
                ),
              ),
              Text(
                product.price.toString(),
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2,
                  decorationColor: Colors.grey,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
