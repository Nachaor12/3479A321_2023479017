import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:application_laboratorio/entity/activity.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  
  factory DatabaseHelper() {
    return _instance;
  }


  DatabaseHelper._internal();
    Future<void> initializeDatabase() async {
    await database;
  }


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activity_database.db');
    return await openDatabase(
    path,
    version: 1,
    onCreate: _onCreate,
    );
  }


  Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE activities (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      date TEXT NOT NULL
    )
    ''');
  }


  Future<void> insertActivity(Activity activity) async {
  final db = await database;
  await db.insert(
    'activities',
    activity.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteActivity(int id) async {
    final db = await database;
    await db.delete(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDataBase() async {
    final db = await database;
    await db.delete('activities');
  }

  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activities');


    return List.generate(maps.length, (i) {
        return Activity.fromMap(maps[i]);
      }
    );
  }

  Future<void> updateActivity(Activity activity) async {
    final db = await database;

    await db.update(
      'activities',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],                                                                
    );
  }

}

