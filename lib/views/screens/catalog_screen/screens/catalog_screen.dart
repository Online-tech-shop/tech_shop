import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/models/category_name.dart';
import 'package:tech_shop/views/screens/catalog_screen/widgets/category_tap_widget.dart';
import 'package:tech_shop/views/screens/catalog_screen/widgets/read_textfield_widget.dart';

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
        title: const ReadTextfieldWidget(
          readOnly: true,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final data = categoryList[index];
          return Container(
            alignment: Alignment.center,
            height: 40,
            child: ListTile(
              dense: true,
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => CategoryTapWidget(
                      categoryTitle: data.title,
                      categoryIndex: index,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Image.asset(
                  "assets/icons/product_icons/${data.icon}.png",
                  height: 30,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 20,
              ),
              title: Text(
                data.title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
