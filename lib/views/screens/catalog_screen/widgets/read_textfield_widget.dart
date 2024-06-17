import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/views/screens/catalog_screen/screens/search_page_screen.dart';

class ReadTextfieldWidget extends StatelessWidget {
  final bool readOnly;
  const ReadTextfieldWidget({
    Key? key,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        readOnly: readOnly,
        onTap: readOnly
            ? () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => SearchPageWidget(),
                  ),
                );
              }
            : null,
        scrollPadding: const EdgeInsets.all(10),
        decoration: InputDecoration(
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
          hintText: tr('mahsulot_va_toifalarni_qidirish'),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 12),
        ),
      ),
    );
  }
}
