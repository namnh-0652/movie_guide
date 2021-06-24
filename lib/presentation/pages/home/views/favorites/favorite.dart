import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieguide/presentation/pages/home/views/subviews/movie_item.dart';

import 'favorite_controller.dart';

class TabFavorite extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final movies = controller.movies;
      if (movies.isEmpty) {
        return Center(
          child: Text(
            "No Favorite Movie !",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        );
      }

      return CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MovieItem(movies[index]);
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
    });
  }
}
