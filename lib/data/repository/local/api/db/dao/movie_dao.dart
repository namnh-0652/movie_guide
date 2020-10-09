import 'package:movieguide/data/model/movie_data.dart';
import 'package:sqflite/sqlite_api.dart';

import 'dart:async';

class MovieDao {
  static const String TABLE_NAME = "Movie";
  static const COLUMN_NAMES = <String>[
    "id",
    "poster_path",
    "title",
    "vote_count",
    "vote_average",
    "release_date",
  ];

  static String createTableQuery =
      "CREATE TABLE $TABLE_NAME(${COLUMN_NAMES[0]} INTEGER PRIMARY KEY,"
      " ${COLUMN_NAMES[1]} TEXT,"
      " ${COLUMN_NAMES[2]} TEXT,"
      " ${COLUMN_NAMES[3]} INTEGER,"
      " ${COLUMN_NAMES[4]} NUM," //? should be double
      " ${COLUMN_NAMES[5]} TEXT);";

  final Database database;

  MovieDao({this.database}) : super();

  Future<int> insert(MovieData movie) async {
    return database.insert(
      TABLE_NAME,
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertAll(List<MovieData> movies) async {
    final batch = database.batch();
    for (MovieData movie in movies) {
      batch.insert(
        TABLE_NAME,
        movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final result = await batch.commit();
    return result.length;
  }

  Future<int> update(MovieData movie) async {
    return database.update(
      TABLE_NAME,
      movie.toJson(),
      where: "${COLUMN_NAMES[0]} = ?",
      whereArgs: [movie.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<MovieData> get(int id) async {
    final json = await database.query(
      TABLE_NAME,
      where: "${COLUMN_NAMES[0]} = ?",
      whereArgs: [id],
    );
    return MovieData.fromJson(json.first);
  }

  Future<List<MovieData>> getAll() async {
    final json = await database.query(TABLE_NAME);
    return json.map((e) => MovieData.fromJson(e)).toList();
  }

  Future<int> deleteById(int id) {
    return database.delete(
      TABLE_NAME,
      where: "${COLUMN_NAMES[0]} = ?",
      whereArgs: [id],
    );
  }

  Future<int> delete() async {
    return database.delete(TABLE_NAME);
  }
}
