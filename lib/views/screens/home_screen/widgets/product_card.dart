import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/utils/routes.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteName.viewProduct,
        arguments: {'product': product},
      ),
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
                  product.images[0],
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
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
                const Row(
                  children: [
                    Icon(Icons.star, color: Color(0XffF59815), size: 15),
                    Text("7.9", style: TextStyle(color: Colors.grey)),
                    Text("(11ta baho)")
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  product.price.toString(),
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                      decorationColor: Colors.grey,
                      color: Colors.grey,
                      fontSize: 14),
                ),
                Text(
                  product.category.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
