import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/Models/upcoming_movies.dart';
import 'package:test_project/View/movie_detail.dart';
import 'package:test_project/utils/app_colors.dart';
import 'package:test_project/utils/tmdb_api_key.dart';
import '../../Controllers/movies_controller.dart';
import '../../utils/App-TextStyle.dart';

class SearchCard extends StatelessWidget {
  final MovieDetail movie;
  const SearchCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(MovieDetailScreen(movie: movie));
        Get.find<MoviesController>().getVideos(movie.id??0);
      },
      child: CachedNetworkImage (
        imageUrl: "$imagepath${movie.backdropPath}",
        imageBuilder: (context, imageProvider) => Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              height: 120,
              width: 150,
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title??"N/A",style: AppTextStyle.mediumBlack14,),
                SizedBox(height: 10,),
                Text(Get.find<MoviesController>().geners[movie.genreIds![0].toString()]??"N/A",style: AppTextStyle.regulargrey12,),
              ],
            )),
            Icon(Iconsax.more)
          ],
        ),
        placeholder: (context, url) =>
        const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => const SizedBox(height: 200, child: Center(child: Icon(Icons.error))),
      ),
    );
  }
}
