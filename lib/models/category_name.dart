
class CategoryName {
  String title;
  String icon;

  CategoryName({
    required this.icon,
    required this.title,
  });
}

List<CategoryName> categoryList = [
  CategoryName(icon: "headphone", title: "Elektronika"),
  CategoryName(icon: "cloth", title: "Kiyim"),
  CategoryName(icon: "shoe", title: "Poyabzallar"),
  CategoryName(icon: "blender", title: "Maishiy texnika"),
  CategoryName(icon: "car", title: "Avtotovarlar"),
  CategoryName(icon: "apple", title: "Oziq-ovqat"),
];
