import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pantone_book/model/pantone_model.dart';

class PantoneColorDatabase {
  static final PantoneColorDatabase instance = PantoneColorDatabase._init();

  static Database? _database;

  PantoneColorDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pantone_colors.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE pantone_colors ( 
      id $idType, 
      pantone_code $textType,
      color_name $textType,
      red $intType,
      green $intType,
      blue $intType
    )
    ''');
  }

  Future<int> insertPantoneColor(PantoneColor pantoneColor) async {
    final db = await instance.database;
    return await db.insert('pantone_colors', pantoneColor.toMap());
  }

  Future<List<PantoneColor>> fetchAllPantoneColors() async {
    final db = await instance.database;
    final result = await db.query('pantone_colors');
    return result.map((map) => PantoneColor.fromMap(map)).toList();
  }

  Future<PantoneColor?> fetchPantoneColorById(int id) async {
    final db = await instance.database;
    final result = await db.query('pantone_colors', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return PantoneColor.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<bool> isDatabaseLoaded() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM pantone_colors');
    int count = Sqflite.firstIntValue(result)!;

    return count > 0; // Returns true if data exists, false if empty
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
