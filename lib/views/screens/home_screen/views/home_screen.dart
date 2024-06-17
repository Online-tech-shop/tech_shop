import 'package:flutter/material.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/carousel_widget.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/category_widget.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/product_widget.dart';
import 'package:tech_shop/views/screens/catalog_screen/widgets/read_textfield_widget.dart';

import '../../../../viewmodels/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor:CustomFunctions.isLight(context) ? Colors.transparent : Colors.black,
          shadowColor:CustomFunctions.isLight(context) ? Colors.transparent : Colors.black,
          title: ReadTextfieldWidget(readOnly: true),
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
                      color: CustomFunctions.isLight(context)
                          ? const Color(0xFFF2F4F7)
                          : Colors.grey.withOpacity(0.1),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    dividerColor: Colors.transparent,
                    labelColor: Color(0xFF7B28DA),
                    indicatorColor: Color(0xFF7B28DA),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                    indicatorWeight: 2.5,
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
              ProductGrid(viewModel: viewModel, isSelected: false),
              ProductGrid(viewModel: viewModel, isSelected: true)
            ],
          ),
        ),
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
      color: CustomFunctions.isLight(context) ? Colors.white : Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
