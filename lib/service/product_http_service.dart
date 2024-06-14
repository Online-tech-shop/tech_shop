import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tech_shop/models/product_item.dart';

class ProductHttpService {
  final Uri _url = Uri.parse(
      'https://to-do-f5021-default-rtdb.firebaseio.com/product.json');

  Future<List<Product>> getProducts() async {
    try {
      final http.Response response = await http.get(_url);
      if (response.body == 'null') {
        throw 'null';
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<Product> loadedProducts = [];
        data.forEach(
          (key, value) {
            value['id'] = key;
            loadedProducts.add(Product.fromJson(value));
          },
        );

        return loadedProducts;
      }
      throw Exception('error: ProductHttpService().getProduct()');
    } catch (e) {
      debugPrint('error: ProductHttpService().getProduct(): $e');
      rethrow;
    }
  }
}
