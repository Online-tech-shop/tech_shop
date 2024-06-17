import 'package:easy_localization/easy_localization.dart';

class FiltrModel {
  String title;
  bool isSelected;

  FiltrModel({
    required this.isSelected,
    required this.title,
  });
}

List<FiltrModel> filtrList = [
  FiltrModel(isSelected: false, title: "arzonroq".tr()),
  FiltrModel(isSelected: false, title: "qimmatroq".tr()),
  FiltrModel(isSelected: false, title: "yuqori_reyting".tr()),
];
