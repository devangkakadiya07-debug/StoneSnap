import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/rock.dart';

class RocksDatabase {
  RocksDatabase._();

  static final RocksDatabase instance = RocksDatabase._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(directory.path, 'stonesnap.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE rocks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            type TEXT NOT NULL,
            color TEXT NOT NULL,
            hardness TEXT NOT NULL,
            description TEXT NOT NULL,
            image_path TEXT NOT NULL
          )
          ''',
        );
      },
    );
  }

  Future<Rock> saveRock(Rock rock) async {
    final db = await database;
    final persistedPath = await _persistImage(rock.imagePath);
    final updated = rock.copyWith(imagePath: persistedPath);
    final id = await db.insert('rocks', updated.toMap());
    return updated.copyWith(id: id);
  }

  Future<List<Rock>> fetchRocks() async {
    final db = await database;
    final maps = await db.query('rocks', orderBy: 'id DESC');
    return maps.map(Rock.fromMap).toList();
  }

  Future<List<Rock>> searchRocks(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return fetchRocks();
    }
    final db = await database;
    final maps = await db.query(
      'rocks',
      where: 'LOWER(name) LIKE ?',
      whereArgs: ['%${trimmed.toLowerCase()}%'],
      orderBy: 'id DESC',
    );
    return maps.map(Rock.fromMap).toList();
  }

  Future<String> _persistImage(String sourcePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(path.join(directory.path, 'rock_images'));
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    final extension = path.extension(sourcePath);
    final filename = '${DateTime.now().millisecondsSinceEpoch}$extension';
    final newPath = path.join(imagesDir.path, filename);
    await File(sourcePath).copy(newPath);
    return newPath;
  }
}
