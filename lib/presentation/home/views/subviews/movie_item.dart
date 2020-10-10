import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/presentation/home/views/subviews/favorite_button.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Go to detail
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: ApiConfig.IMAGE_BASE_URL + movie.posterPath,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: FavoriteButton(movie: movie),
          )
        ],
      ),
    );
  }
}
