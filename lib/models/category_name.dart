import 'package:easy_localization/easy_localization.dart';

class CategoryName {
  String title;
  String icon;

  CategoryName({
    required this.icon,
    required this.title,
  });
}

List<CategoryName> categoryList = [
  CategoryName(icon: "headphone", title: "elektronika".tr()),
  CategoryName(icon: "cloth", title: "kiyim".tr()),
  CategoryName(icon: "shoe", title: "poyabzallar".tr()),
  CategoryName(icon: "blender", title: "maishiy_texnika".tr()),
  CategoryName(icon: "car", title: "avtotovarlar".tr()),
  CategoryName(icon: "apple", title: "oziqovqat".tr()),
];
