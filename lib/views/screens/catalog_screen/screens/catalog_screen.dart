import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: ReadTextfieldWidget(
          readOnly: true,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => CategoryTapWidget(
                    categoryIndex: index,
                  ),
                ),
              );
            },
            leading: const CircleAvatar(
              backgroundColor: Color(0xffF3F4F8),
              backgroundImage: AssetImage("assets/images/category1.png"),
            ),
            title: const Text("Categoriya nomi"),
          );
        },
      ),
    );
  }
}
