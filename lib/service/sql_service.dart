import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tech_shop/models/sql_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'saves_product4.db',
    ); // Changed the database name
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE saves_product4 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        image TEXT NOT NULL,
        price REAL NOT NULL,
        amount INTEGER NOT NULL,
        seller TEXT NOT NULL,
        brieflyAboutProduct TEXT,
        quantity INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertSave(Save save) async {
    final db = await database;
    return await db.insert('saves_product4', save.toMap());
  }

  Future<List<Save>> getSaves() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('saves_product4');

    return List.generate(maps.length, (i) => Save.fromMap(maps[i]));
  }

  Future<int> updateSave(Save save) async {
    final db = await database;
    return await db.update(
      'saves_product4',
      save.toMap(),
      where: 'id = ?',
      whereArgs: [save.id],
    );
  }

  Future<int> deleteSave(int id) async {
    final db = await database;
    return await db.delete(
      'saves_product4',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
