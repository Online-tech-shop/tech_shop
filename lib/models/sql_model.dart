class Save {
  int? id;
  final String title;
  final String image;
  double price;
  final int amount;
  final String seller;
  final String? brieflyAboutProduct;
  int quantity;

  Save({
    this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.amount,
    required this.seller,
    this.brieflyAboutProduct,
    required this.quantity,
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
      'quantity': quantity,
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
      quantity: map['quantity'],
    );
  }
}
