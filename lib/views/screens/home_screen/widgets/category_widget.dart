import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';

class CategoryList extends StatelessWidget {
  final HomeViewModel viewModel;

  const CategoryList({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.categoryItems.length,
        itemBuilder: (context, index) {
          final categoryItem = viewModel.categoryItems[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => viewModel.onCategoryItemTap(index),
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(categoryItem.imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(categoryItem.name),
            ],
          );
        },
      ),
    );
  }
}
