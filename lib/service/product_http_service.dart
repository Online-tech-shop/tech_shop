import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tech_shop/models/product_item.dart';

class ProductHttpService {
  final Uri _url = Uri.parse(
      'https://uzum-market-81608-default-rtdb.firebaseio.com/product.json');

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

  Future<List<Product>> addFavoriteProducts(
    String id,
    String name,
    int price,
    int category,
    List<String> images,
    String seller,
    int orderAmount,
    int boughtAmountThisWeek,
    String aboutProduct,
    List<int> saleType,
    List<String> brieflyAboutProduct,
    bool isFavorite,
  ) async {
    try {
      Uri url = Uri.parse(
          "https://uzum-market-81608-default-rtdb.firebaseio.com/favorite.json");
      http.post(url,
          body: jsonEncode({
            "id": id,
            "name": name,
            "price": 100,
            "category": category,
            "image": images,
            "seller": seller,
            "orderAmount": orderAmount,
            "boughtAmountThisWeek": boughtAmountThisWeek,
            "aboutProduct": aboutProduct,
            "saleType": saleType,
            "brieflyAboutProduct": brieflyAboutProduct,
            "isFavorite": isFavorite,
          }));
      throw 'null';
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Product>> getFavoriteProducts() async {
    Uri url = Uri.parse(
        "https://uzum-market-81608-default-rtdb.firebaseio.com/favorite.json");
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

  Future<void> deleteFavoritProduct(String id) async {
    Uri url = Uri.parse(
        "https://uzum-market-81608-default-rtdb.firebaseio.com/favorite/$id.json");
    try {
      http.delete(url);
    } catch (e) {
      throw (e);
    }
  }
}
