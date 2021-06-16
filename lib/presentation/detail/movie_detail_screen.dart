import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieguide/presentation/detail/bloc/moviedetail_bloc.dart';
import 'package:movieguide/shared/common_ext.dart';

import '../../di.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final int movieId;
  final String heroImageURL;
  final String heroImageTag;

  MovieDetailScreen({
    required this.title,
    required this.movieId,
    required this.heroImageURL,
    required this.heroImageTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                background: Hero(
                  tag: heroImageTag,
                  child: CachedNetworkImage(
                    imageUrl: heroImageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ];
        },
        body: BlocProvider(
          create: (_) => MoviedetailBloc(movieDetailUseCase: getIt.get())
            ..add(GetMovieDetailEvent(movieId: movieId)),
          child: _buildDetailView(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.favorite_border,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildDetailView(BuildContext context) {
    return BlocBuilder<MoviedetailBloc, MoviedetailState>(
      builder: (context, state) {
        if (state is MoviedetailInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MoviedetailError) {
          return Center(
            child: Text("Can not get detail! \nCause by ${state.errorMessage}"),
          );
        } else {
          final movie = (state as MoviedetailLoaded).movieDetail;
          if (movie == null) return Container();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                movie.title.orEmpty(),
                style: TextStyle(fontSize: 28.0),
              ),
              SizedBox(height: 10),
              Text(
                "Release Date: ${movie.releaseDate}",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 4),
              Text(
                "${movie.voteAverage ?? 0} / 10",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Summary",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                movie.overview.orEmpty(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
