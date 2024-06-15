class Save {
  int? id;
  String title;
  String image;
  String price;
  String amount;
  String seller;
  String brieflyAboutProduct;

  Save({
    this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.amount,
    required this.seller,
    required this.brieflyAboutProduct,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'amount': amount,
      'seller': seller,
      'brieflyAboutProduct': brieflyAboutProduct,
    };
  }

  factory Save.fromMap(Map<String, dynamic> map) {
    return Save(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      price: map['price'],
      amount: map['amount'],
      seller: map['seller'],
      brieflyAboutProduct: map['brieflyAboutProduct'],
    );
  }
}
