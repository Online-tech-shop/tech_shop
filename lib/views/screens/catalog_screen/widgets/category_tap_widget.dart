import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/utils/functions.dart';
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
  final _textController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
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
              fillColor: CustomFunctions.isLight(context)
                  ? const Color(0xffF3F4F8)
                  : Colors.black,
              hintStyle: const TextStyle(
                color: Color(0xff8B8B95),
              ),
              hintText: "termada_qidirish".tr(),
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
