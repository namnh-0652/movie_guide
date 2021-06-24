import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'movie_detail_controller.dart';

class MovieDetailScreen extends GetView<MovieDetailController> {
  final String title = Get.arguments["title"];
  final String heroImageURL = Get.arguments["heroImageURL"];
  final String heroImageTag = Get.arguments["heroImageTag"];

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
        body: Obx(() => _buildDetailView(context)),
      ),
    );
  }

  Widget _buildDetailView(BuildContext context) {
    if (controller.getMovieDetailState.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (controller.getMovieDetailState.isError) {
      return Center(
        child: Text(
            "Can not get detail! \nCause by ${controller.getMovieDetailState.errorMessage}"),
      );
    } else {
      final movie = controller.movieDetail;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              movie.title,
              style: TextStyle(fontSize: 28.0),
            ),
            SizedBox(height: 10),
            Text(
              "Release Date: ${movie.releaseDate}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Revenue: ${NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0).format(movie.revenue)}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Summary",
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 2),
            Text(
              movie.overview,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    }
  }
}
