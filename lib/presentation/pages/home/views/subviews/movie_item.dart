import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/presentation/routes/app_pages.dart';

import 'favorite_button.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final moviePosterURL = ApiConfig.IMAGE_BASE_URL + (movie.posterPath ?? "");
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(
              Routes.MOVIE_DETAIL,
              arguments: {
                'title': movie.title,
                'movieId': movie.id,
                'heroImageURL': moviePosterURL,
                'heroImageTag': moviePosterURL,
              },
            );
          },
          child: CachedNetworkImage(
            imageUrl: moviePosterURL,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: FavoriteButton(movie),
          ),
        )
      ],
    );
  }
}
