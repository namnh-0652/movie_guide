import 'package:movieguide/domain/entities/base_entity.dart';

class Movie extends Entity {
  int id;
  String posterPath;
  String title;
  int voteCount;
  double voteAverage;
  String releaseDate;
  Movie({
    this.id,
    this.posterPath,
    this.title,
    this.voteCount,
    this.voteAverage,
    this.releaseDate,
  });
}
