import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieguide/presentation/pages/home/views/subviews/bottom_loading.dart';
import 'package:movieguide/presentation/pages/home/views/subviews/movie_item.dart';

import 'rated_controller.dart';

class TabRated extends GetView<RatedController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.getMovieState.isLoading && controller.nextPage == 1) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.getMovieState.isError) {
        return Center(
          child: Text(
              "Can not get detail! \nCause by ${controller.getMovieState.errorMessage}"),
        );
      } else {
        return _buildMovieList(context);
      }
    });
  }

  Widget _buildMovieList(BuildContext context) {
    final movies = controller.movies;
    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      child: CustomScrollView(
        controller: controller.scrollController,
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
          SliverToBoxAdapter(
            child: controller.hasReachedEnd ? SizedBox() : BottomLoading(),
          )
        ],
      ),
    );
  }
}
