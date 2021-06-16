import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieguide/di.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/presentation/home/bloc/movielist/movielist_bloc.dart';
import 'package:movieguide/presentation/home/views/subviews/bottom_loading.dart';
import 'package:movieguide/presentation/home/views/subviews/movie_item.dart';
import 'package:movieguide/shared/common_ext.dart';

class TabNewest extends StatelessWidget {
  const TabNewest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovielistBloc(getMovieUseCase: getIt.get())
        ..fectchMovies(MovieKind.newest),
      child: NewestMovies(),
    );
  }
}

class NewestMovies extends StatefulWidget {
  @override
  _NewestMoviesState createState() => _NewestMoviesState();
}

class _NewestMoviesState extends State<NewestMovies> {
  final ScrollController _scrollController = ScrollController();
  MovielistBloc? _movielistBloc;
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
    if (currentScroll >= maxScroll - delta &&
        !(_movielistBloc?.isLoading ?? false)) {
      _movielistBloc?.fectchMovies(MovieKind.newest);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _movielistBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovielistBloc, MovielistState>(
      builder: (context, state) {
        if (state is MovielistInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovielistError) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage.orEmpty())));
          });

          return Container();
        }
        return _buildMovieList(context, state as MovielistLoaded);
      },
    );
  }

  Widget _buildMovieList(BuildContext context, MovielistLoaded state) {
    final movies = state.movies;
    if (_movielistBloc == null) return Container();
    return RefreshIndicator(
      onRefresh: () => _movielistBloc!.refresh(MovieKind.newest),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MovieItem(movie: movies[index]);
              },
              childCount: movies.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 9 / 13,
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
          ),
          SliverToBoxAdapter(
            child: state.hasReachedEnd ? SizedBox() : BottomLoading(),
          )
        ],
      ),
    );
  }
}
