import 'package:flutter/cupertino.dart';

class FiltrModel {
  String title;
  bool isSelected;

  FiltrModel({
    required this.isSelected,
    required this.title,
  });
}

List<FiltrModel> filtrList = [
  FiltrModel(isSelected: false, title: "Arzonroq"),
  FiltrModel(isSelected: false, title: "Qimmatroq"),
];
