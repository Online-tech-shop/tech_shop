import 'package:flutter/material.dart';
import 'package:tech_shop/viewmodels/home_view_model.dart';
import 'package:tech_shop/views/screens/catalog_screen/widgets/show_products_widget.dart';

class SearchPageWidget extends StatefulWidget {
  HomeViewModel homeViewModel = HomeViewModel();

  SearchPageWidget({
    super.key,
  });

  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  String searchText = '';
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: _textController,
            autofocus: true,
            scrollPadding: const EdgeInsets.all(10),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _textController.clear();
                  searchText = '';
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
              hintText: "Termada qidirish",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 12),
            ),
          ),
        ),
      ),
      body: ShowProductsWidget(
        viewModel: widget.homeViewModel,
        searchText: searchText,

      ),
    );
  }
}
