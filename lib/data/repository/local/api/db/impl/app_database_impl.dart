import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:movieguide/data/repository/local/api/db/app_database.dart';
import 'package:movieguide/data/repository/local/api/db/dao/movie_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

class AppDataBaseImpl implements AppDatabase {
  static const DATABASE_NAME = "movie_guide.db";
  static const DATABASE_VERSION = 1;
  static final AppDataBaseImpl instance = AppDataBaseImpl._();

  AppDataBaseImpl._();
  Database _database;
  MovieDao _movieDao;

  @override
  Future<void> init() async {
    _database ??= await _initAndOpenDatabase();
  }

  _initAndOpenDatabase() async {
    final databasePath = await getDatabasesPath();
    try {
      await Directory(databasePath).create(recursive: true);
    } catch (_) {}
    final path = join(databasePath, DATABASE_NAME);
    return await openDatabase(
      path,
      version: DATABASE_VERSION,
      onCreate: _onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
      onUpgrade: _onUpgrade,
    );
  }

  @override
  MovieDao movieDao() {
    assert(_database != null, "must init database first!");
    _movieDao ??= MovieDao(database: _database);
    return _movieDao;
  }

  Future _onCreate(Database db, int version) async {
    final batch = db.batch();
    final v1Batches = _databaseV1Queries();
    for (String query in v1Batches) {
      batch.execute(query);
    }
    await batch.commit();
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    if (oldVersion == 1 && newVersion == 2) {
      final v2Batches = _databaseV2Queries();
      for (String query in v2Batches) {
        batch.execute(query);
      }
    }
    // Other version
    await batch.commit();
  }

  Future<void> close() async {
    await _database.close();
  }

  /// This is array of create queries table
  /// This is version V1 for example
  _databaseV1Queries() {
    return <String>[
      MovieDao.createTableQuery,
      // Other
    ];
  }

  /// This is sample for V2 version
  // ignore: unused_function
  _databaseV2Queries() {
    return <String>[];
  }
}
