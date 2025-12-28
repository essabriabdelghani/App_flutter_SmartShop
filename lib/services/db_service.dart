import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'favorites.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE,
            price REAL,
            imagePath TEXT
          )
        ''');
      },
    );
  }

  // Vérifie si le produit est déjà favori par name
  Future<bool> isFavorite(String name) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  // Ajoute un favori uniquement s'il n'existe pas
  Future<bool> addFavorite(Map<String, dynamic> product) async {
    final db = await database;

    final exists = await isFavorite(product['name']);
    if (exists) return false; // déjà favori

    await db.insert(
      'favorites',
      product,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    return true;
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }

  Future<void> removeFavorite(String name) async {
    final db = await database;
    await db.delete('favorites', where: 'name = ?', whereArgs: [name]);
  }
}
