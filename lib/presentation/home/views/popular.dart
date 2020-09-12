import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/di.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/presentation/home/bloc/movielist_bloc.dart';

class TabPopular extends StatelessWidget {
  const TabPopular({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovielistBloc(getMovieUseCase: getIt.get())
        ..fectchMovies(MovieKind.popular),
      child: PopularMovies(),
    );
  }
}

class PopularMovies extends StatefulWidget {
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  final ScrollController _scrollController = ScrollController();
  MovielistBloc _movielistBloc;
  @override
  void initState() {
    super.initState();
    _movielistBloc = BlocProvider.of(context);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = 200.0;
    if (currentScroll >= maxScroll - delta && !_movielistBloc.isLoading) {
      _movielistBloc?.fectchMovies(MovieKind.popular);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _movielistBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovielistBloc, MovielistState>(
      builder: (context, state) {
        if (state is MovielistInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovielistError) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text(state.errorMessage),
              );
            },
          );
          return Container();
        }
        return _buildMovieList(context, state);
      },
    );
  }

  Widget _buildMovieList(BuildContext context, MovielistLoaded state) {
    final movies = state.movies;
    return RefreshIndicator(
      onRefresh: () => _movielistBloc.refresh(MovieKind.popular),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildMovieItem(context, movies[index]);
              },
              childCount: movies.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 9 / 13,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
          ),
          SliverToBoxAdapter(
              child: state.hasReachedEnd ? SizedBox() : _bottomLoading())
        ],
      ),
    );
  }

  Widget _bottomLoading() {
    return Container(
      child: CircularProgressIndicator(),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15),
    );
  }

  Widget _buildMovieItem(BuildContext context, Movie movie) {
    return InkWell(
      onTap: () {},
      child: CachedNetworkImage(
        imageUrl: ApiConfig.IMAGE_BASE_URL + movie.posterPath,
        fit: BoxFit.fill,
      ),
    );
  }
}
