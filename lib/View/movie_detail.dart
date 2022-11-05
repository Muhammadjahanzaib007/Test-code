import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:test_project/Controllers/movies_controller.dart';
import 'package:test_project/Models/movie_video_model.dart';
import 'package:test_project/Models/upcoming_movies.dart';
import 'package:test_project/View/youtube_player.dart';

import '../utils/App-TextStyle.dart';
import '../utils/app_colors.dart';
import '../utils/tmdb_api_key.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieDetail movie;
   MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

   List<Color> mycolors = [
    AppColors.blueGreen,
    AppColors.myPink,
    AppColors.myPurple,
    AppColors.myYellow ,
  ];
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Material(
      child: Flex(
        direction: orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        children: [
          Expanded(
              flex: 6,
              child: CachedNetworkImage(
                imageUrl: "$imagepath${movie.posterPath}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      SafeArea(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  CupertinoIcons.back,
                                  color: Colors.white,
                                )),
                            Text(
                              "Watch",
                              style: AppTextStyle.mediumWhite14,
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: orientation == Orientation.landscape
                            ? 1
                            : 50,),
                        child: Column(
                          children: [
                            Text("In Theater ${DateFormat("MMMM dd,yyyy").format(DateTime.parse(movie.releaseDate??"2022-01-01"))}",style: AppTextStyle.mediumWhite14,),
                            Flex(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              direction: orientation == Orientation.landscape
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      height: 55,
                                      constraints: BoxConstraints(minWidth: 180),
                                      decoration: BoxDecoration(
                                          color: AppColors.skyBlue,
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Center(child: Text("Get Tickets",style: AppTextStyle.mediumWhite14,)),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      var cont = Get.find<MoviesController>();
                                      MovieVideo video = cont.movieVideos.where((e) => e.type=="Trailer").first;
                                      Get.to(TrailerScreen(id: video.key!));
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(minWidth: 180),
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.all(color: AppColors.skyBlue),
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons.play_arrow_solid,color: Colors.white,size: 20,),
                                          SizedBox(width: 10,),
                                          Text("Watch Trailer",style: AppTextStyle.mediumWhite14,),
                                        ],
                                      )),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                placeholder: (context, url) =>
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.darkGrey),
                      child: Column(
                        children: [
                          SafeArea(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.back,
                                      color: Colors.white,
                                    )),
                                Text(
                                  "Watch",
                                  style: AppTextStyle.mediumWhite14,
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: orientation == Orientation.landscape
                                ? 1
                                : 50,),
                            child: Column(
                              children: [
                                Text("In Theater ${DateFormat("MMMM dd,yyyy").format(DateTime.parse(movie.releaseDate??"2022-01-01"))}",style: AppTextStyle.mediumWhite14,),
                                Flex(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  direction: orientation == Orientation.landscape
                                      ? Axis.horizontal
                                      : Axis.vertical,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: Container(
                                          height: 55,
                                          constraints: BoxConstraints(minWidth: 180),
                                          decoration: BoxDecoration(
                                              color: AppColors.skyBlue,
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Center(child: Text("Get Tickets",style: AppTextStyle.mediumWhite14,)),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          var cont = Get.find<MoviesController>();
                                          MovieVideo video = cont.movieVideos.where((e) => e.type=="Trailer").first;
                                          Get.to(TrailerScreen(id: video.key!));
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(minWidth: 180),
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              border: Border.all(color: AppColors.skyBlue),
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Center(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(CupertinoIcons.play_arrow_solid,color: Colors.white,size: 20,),
                                              SizedBox(width: 10,),
                                              Text("Watch Trailer",style: AppTextStyle.mediumWhite14,),
                                            ],
                                          )),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              ),

          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Genres",style: AppTextStyle.boldBlack16,),
                    Wrap(
                      children: [
                        for(int i=0; i < movie.genreIds!.length ;i++)
                        Container(
                         padding: EdgeInsets.symmetric(horizontal: 8,vertical: 1),
                          margin: EdgeInsets.only(right: 10,top: 10),
                          
                          decoration: BoxDecoration(
                            color: mycolors[i%4],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(Get.find<MoviesController>().geners['${movie.genreIds![i]}'],style: AppTextStyle.regularWhite12,),
                        )
                      ],
                    ),
                    SizedBox(height: 25,),
                    Text("Overview",style: AppTextStyle.boldBlack16,),
                    Text(movie.overview??"N/A",style: AppTextStyle.regulargrey12,),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
