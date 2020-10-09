import 'package:flutter/material.dart';
import 'package:movieguide/presentation/home/provider/favorite_movie_notifier.dart';
import 'package:movieguide/presentation/home/views/subviews/movie_item.dart';
import 'package:provider/provider.dart';

class TabFavorite extends StatefulWidget {
  const TabFavorite({Key key}) : super(key: key);

  @override
  _TabFavoriteState createState() => _TabFavoriteState();
}

class _TabFavoriteState extends State<TabFavorite> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movies = context.watch<FavoriteMovieChangeNotifier>().favoriteMovies;
    return movies.isEmpty
        ? Center(
            child: Text(
              "No Favorite Movie !",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          )
        : CustomScrollView(
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
            ],
          );
  }
}
