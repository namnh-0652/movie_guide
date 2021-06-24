import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/presentation/pages/home/views/favorites/favorite_controller.dart';

class FavoriteButton extends StatelessWidget {
  final Movie movie;
  final favoriteController = Get.find<FavoriteController>();
  FavoriteButton(this.movie);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isFavorite = favoriteController.movies.contains(movie);
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
              ? favoriteController.removeFromFavorite(movie)
              : favoriteController.addToFavorite(movie);
        },
      );
    });
  }
}
