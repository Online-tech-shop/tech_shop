import 'package:flutter/foundation.dart';
import 'package:tech_shop/models/sql_model.dart';
import 'package:tech_shop/service/sql_service.dart';

class SaveViewModel extends ChangeNotifier {
  List<Save> _saves = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Save> get saves => _saves;

  Future<void> fetchSaves() async {
    _saves = await _dbHelper.getSaves();
    notifyListeners();
  }

  Future<void> addSave(Save save) async {
    await _dbHelper.insertSave(save);
    fetchSaves();
  }

  Future<void> updateSave(Save save) async {
    await _dbHelper.updateSave(save);
    fetchSaves();
  }

  Future<void> deleteSave(int id) async {
    await _dbHelper.deleteSave(id);
    fetchSaves();
  }
}
