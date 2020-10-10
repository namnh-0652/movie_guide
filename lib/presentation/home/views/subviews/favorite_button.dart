import 'package:flutter/material.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/presentation/home/provider/favorite_movie_notifier.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Movie movie;

  FavoriteButton({this.movie});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteMovieChangeNotifier>(
        builder: (context, notifier, child) {
      final isFavorite = notifier.favoriteMovies.contains(movie);
      return IconButton(
        icon: isFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.red,
                size: 50,
              )
            : Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 50,
              ),
        onPressed: () {
          isFavorite
              ? notifier.removeFromFavorite(movie)
              : notifier.addToFavorite(movie);
        },
      );
    });
  }
}
