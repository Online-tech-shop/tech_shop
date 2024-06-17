import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/product_item.dart';

class FavouriteViewModel {
  final String _keyName = 'fav';

  Future<List<String>> getFavouriteProductId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(_keyName) ?? [];
  }

  Future<List<Product>> saveNewFavouriteProduct({required String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (id == '') {
        throw Exception('error: id == null');
      }
      List<String> favList = sharedPreferences.getStringList(_keyName) ?? [];
      if (favList == []) {
        sharedPreferences.setStringList(_keyName, [id]);
      } else {
        favList.add(id);
        sharedPreferences.setStringList(_keyName, favList);
      }
      return [];
    } catch (e) {
      throw Exception("Error saving favourite product: $e");
    }
  }

  Future<void> deleteNewFavouriteProduct({required String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (id == '') {
        throw Exception('error: id == null');
      }
      List<String> favList = sharedPreferences.getStringList(_keyName) ?? [];
      if (favList == []) {
        return;
      }
      favList.removeWhere((element) => element == id);
      sharedPreferences.setStringList(_keyName, favList);
    } catch (e) {
      throw Exception("Error deleting favourite product: $e");
    }
  }

  Future<bool> checkIsFav({required String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favList = sharedPreferences.getStringList(_keyName) ?? [];
    if (favList == []) {
      return false;
    }
    for (var element in favList) {
      if (element == id) {
        return true;
      }
    }
    return false;
  }
}
