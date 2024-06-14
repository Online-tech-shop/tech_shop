import 'package:flutter/material.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/search_page_widget.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: TextField(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchPageWidget(),
              ),
            ),
            scrollPadding: const EdgeInsets.all(10),
            decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffF3F4F8),
                hintStyle: TextStyle(
                  color: Color(0xff8B8B95),
                ),
                hintText: "Mahsulot va toifalarni qidirish",
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
