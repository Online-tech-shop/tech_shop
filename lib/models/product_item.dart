import 'review_model.dart';

class Product {
  String? id;
  List<String> name;
  int price;
  int category;
  List<String> images;
  String seller;
  int orderAmount;
  int boughtAmountThisWeek;
  String aboutProduct;
  List<int> saleType;
  List<String> brieflyAboutProduct;
  int leftProduct;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.images,
    required this.seller,
    required this.orderAmount,
    required this.boughtAmountThisWeek,
    required this.aboutProduct,
    required this.saleType,
    required this.brieflyAboutProduct,
    required this.leftProduct,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'images': images,
      'seller': seller,
      'orderAmount': orderAmount,
      'boughtAmountThisWeek': boughtAmountThisWeek,
      'aboutProduct': aboutProduct,
      'saleType': saleType,
      'brieflyAboutProduct': brieflyAboutProduct,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: List<String>.from(json['name']),
      price: json['price'],
      category: json['category'],
      images: List<String>.from(json['images']),
      seller: json['seller'],
      orderAmount: json['order-amount'],
      boughtAmountThisWeek: json['bought-amount-this-week'],
      aboutProduct: json['about-product'],
      saleType: List<int>.from(
        json['sale-type'].map((item) => item as int),
      ),
      brieflyAboutProduct: List<String>.from(
        json['briefly-about-product'],
      ),
      leftProduct: json['left-product'] ?? 0,
    );
  }

  List<Review> getReviews(List<Review> reviews) {
    return reviews.where((Review review) => review.productId == id).toList();
  }
}
