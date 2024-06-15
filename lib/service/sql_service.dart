import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tech_shop/models/sql_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'saves.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE saves (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        image TEXT,
        price TEXT,
        amount TEXT,
        seller TEXT,
        brieflyAboutProduct TEXT
      )
    ''');
  }

  Future<int> insertSave(Save save) async {
    Database db = await database;
    return await db.insert('saves', save.toMap());
  }

  Future<List<Save>> getSaves() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('saves');

    return List.generate(maps.length, (i) {
      return Save.fromMap(maps[i]);
    });
  }

  Future<int> updateSave(Save save) async {
    Database db = await database;
    return await db.update(
      'saves',
      save.toMap(),
      where: 'id = ?',
      whereArgs: [save.id],
    );
  }

  Future<int> deleteSave(int id) async {
    Database db = await database;
    return await db.delete(
      'saves',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
