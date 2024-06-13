
import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';

class ProductGrid extends StatelessWidget {
  final HomeViewModel viewModel;

  const ProductGrid({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 320,
        crossAxisCount: 2,
      ),
      itemCount: viewModel.productItems.length,
      itemBuilder: (context, index) {
        final productItem = viewModel.productItems[index];
        return Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(productItem.imagePath, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productItem.title,
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
                      child: Text(productItem.monthlyPrice),
                    ),
                  ),
                  Text(
                    productItem.originalPrice,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                      decorationColor: Colors.grey,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    productItem.discountedPrice,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
