import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/catalog_screen/widgets/show_products_widget.dart';

class CategoryTapWidget extends StatefulWidget {
  int categoryIndex;
  String categoryTitle;
  CategoryTapWidget({
    required this.categoryTitle,
    required this.categoryIndex,
    super.key,
  });

  @override
  State<CategoryTapWidget> createState() => _CategoryTapWidgetState();
}

class _CategoryTapWidgetState extends State<CategoryTapWidget> {
  HomeViewModel homeViewModel = HomeViewModel();
  String searchText = '';
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leadingWidth: 30,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: _textController,
            autofocus: true,
            onChanged: (value) {
              searchText = value;
              setState(() {});
            },
            scrollPadding: const EdgeInsets.all(10),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  searchText = '';
                  _textController.clear();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.clear,
                  color: Color(0xff8B8B95),
                ),
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
                color: Color(0xff8B8B95),
              ),
              filled: true,
              fillColor: const Color(0xffF3F4F8),
              hintStyle: const TextStyle(
                color: Color(0xff8B8B95),
              ),
              hintText: "termada_qidirishku".tr(),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 12),
            ),
          ),
        ),
      ),
      body: ShowProductsWidget(
        viewModel: homeViewModel,
        searchText: searchText,
        categoryIndex: widget.categoryIndex,
        categoryTitle: widget.categoryTitle,
      ),
    );
  }
}
