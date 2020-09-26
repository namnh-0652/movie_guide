import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/presentation/home/views/subviews/favorite_button.dart';

import '../../../routers.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final moviePosterURL = ApiConfig.IMAGE_BASE_URL + (movie.posterPath ?? "");
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              Routers.detailRoute,
              arguments: {
                'title': movie.title,
                'movieId': movie.id,
                'heroImageURL': moviePosterURL,
                'heroImageTag': '$moviePosterURL',
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
            child: FavoriteButton(movie: movie),
          ),
        )
      ],
    );
  }
}
