import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/views/screens/catalog_screen/screens/search_page_screen.dart';

class ReadTextfieldWidget extends StatelessWidget {
  bool readOnly;
  String hintText;
  ReadTextfieldWidget({
    required this.readOnly,
    this.hintText = 'Mahsulot va toifalarni qidirish',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        readOnly: readOnly,
        onTap: () => readOnly
            ? Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SearchPageWidget(),
                ),
              )
            : null,
        scrollPadding: const EdgeInsets.all(10),
        decoration: const InputDecoration(
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
          hintText: "Mahsulot va toifalarni qidirish",
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 12),
        ),
      ),
    );
  }
}
