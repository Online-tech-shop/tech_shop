import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/models/category_name.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/catalog_screen/widgets/category_tap_widget.dart';

class CategoryList extends StatelessWidget {
  final HomeViewModel viewModel;

  const CategoryList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final data = categoryList[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => CategoryTapWidget(
                      categoryTitle: data.title,
                      categoryIndex: index,
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                      "assets/icons/product_icons/${data.icon}.png"),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                data.title.replaceFirst(" ", "\n"),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
