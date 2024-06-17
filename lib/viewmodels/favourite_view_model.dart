import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/product_item.dart';

class FavouriteViewModel {
  Future<List<Product>> saveNewFavouriteProduct(String id) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String> fav = sharedPreferences.getStringList('fav') ?? [];
      return [];
    } catch (e) {
      throw Exception("Error saving favourite product: $e");
    }
  }
}
