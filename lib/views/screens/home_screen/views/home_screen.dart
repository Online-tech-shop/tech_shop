import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/carousel_widget.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/category_widget.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F4F8),
              label: Text(
                "Mahsulotlar va turkumlar qidirish",
                style: TextStyle(
                  color: Color(0xff8B8B95),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.heart,
                size: 29,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Carousel(viewModel: viewModel),
              const SizedBox(height: 20),
              CategoryList(viewModel: viewModel),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 10,
                color: const Color(0xFFF2F4F7),
              ),
              const SizedBox(height: 10),
              const TabBar(
                tabs: [
                  Tab(text: "Tavsiyalar"),
                  Tab(text: "Yozgi savdo"),
                ],
              ),
              SizedBox(
                height: 900,
                child: TabBarView(
                  children: [
                    ProductGrid(viewModel: viewModel),
                    const Center(
                      child: Text("Yozgi savdo content"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
