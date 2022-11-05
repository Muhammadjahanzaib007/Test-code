import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_project/Models/upcoming_movies.dart';
import 'package:test_project/View/movie_detail.dart';
import 'package:test_project/utils/app_colors.dart';
import 'package:test_project/utils/tmdb_api_key.dart';
import '../../Controllers/movies_controller.dart';
import '../../utils/App-TextStyle.dart';

class MoviesCard extends StatelessWidget {
  final MovieDetail movie;
  const MoviesCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(MovieDetailScreen(movie: movie));
        Get.find<MoviesController>().getVideos(movie.id??0);
      },
      child: CachedNetworkImage(
        imageUrl: "$imagepath${movie.backdropPath}",
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.all( 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
          height: 200,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  movie.title ?? "N/A",
                  style: AppTextStyle.mediumWhite16,
                )),
          ),
        ),
        placeholder: (context, url) =>
            const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => const SizedBox(height: 200, child: Center(child: Icon(Icons.error))),
      ),
    );
  }
}
