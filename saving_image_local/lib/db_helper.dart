import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _database;

  Future<Database> get database async {
    // await deleteDb();
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    var directory = await getDatabasesPath();
    String path = join(directory, "note.db");
    log("Path datase $path");
    return openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE note_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note TEXT DEFAULT NULL,
        image TEXT DEFAULT NULL
      )
      ''');
    } catch (e) {
      log("Exception Create Table note $e");
    }
  }

  Future deleteDb() async {
    var directory = await getDatabasesPath();
    String path = join(directory, "note.db");
    await deleteDatabase(path);
  }
}

final dbHelper = DatabaseHelper();
