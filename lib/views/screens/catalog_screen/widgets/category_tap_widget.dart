import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_widget.dart';

class CategoryTapWidget extends StatelessWidget {
  HomeViewModel homeViewModel = HomeViewModel();
  CategoryTapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const TextField(
            autofocus: true,
            scrollPadding: EdgeInsets.all(10),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 20,
                color: Color(0xff8B8B95),
              ),
              filled: true,
              fillColor: Color(0xffF3F4F8),
              hintStyle: TextStyle(
                color: Color(0xff8B8B95),
              ),
              hintText: "Termada qidirishku",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12),
            ),
          ),
        ),
      ),
      body: ProductGrid(viewModel: homeViewModel),
    );
  }
}
