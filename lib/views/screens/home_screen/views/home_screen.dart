import 'package:flutter/material.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/carousel_widget.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/category_widget.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_widget.dart';

import '../../../../viewmodels/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color(0xFFF3F4F8),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: Text(
                textAlign: TextAlign.left,
                "Mahsulot va toifalarni qidirish",
                style: TextStyle(
                  color: Color(0xff8B8B95),
                ),
              ),
            ),
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
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
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                const TabBar(
                  tabs: [
                    Tab(text: "Tavsiyalar"),
                    Tab(text: "Yozgi savdo"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          children: [
            ProductGrid(viewModel: viewModel),
            const Center(
              child: Text("Yozgi savdo content"),
            ),
          ],
        ),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        children: [
          ProductGrid(viewModel: viewModel),
          ProductGrid(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
