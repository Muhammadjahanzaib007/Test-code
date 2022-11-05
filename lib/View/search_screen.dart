import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/View/Widgets/app_textfield.dart';
import 'package:test_project/View/Widgets/search_card.dart';
import 'package:test_project/utils/app_colors.dart';
import '../Controllers/movies_controller.dart';
import '../Models/upcoming_movies.dart';

class MovieSearchScreen extends StatelessWidget {
  MovieSearchScreen({Key? key}) : super(key: key);

  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: AppTextField(
              width: Get.width,
              controller: searchC,
              bgColor: AppColors.lightGrey,
              onChange: (text) async {
               await Future.delayed(const Duration(seconds: 1));
               Get.find<MoviesController>().searchMovies(text??"");
              },
              leading: const Icon(
                Iconsax.search_normal_14,
                color: AppColors.black,
              ),
              trailing: IconButton(
                icon: Icon(
                  CupertinoIcons.xmark,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              hint: "TV Shows, Movies and more",
            ),
          )),
          Expanded(
            child: GetBuilder<MoviesController>(
                autoRemove: false,
                builder: (cont) => cont.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                  color: AppColors.bgColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: OrientationBuilder(
                          builder: (context, orientation) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    (orientation == Orientation.portrait)
                                        ? 1
                                        : 2,
                                childAspectRatio: 2.5,
                              ),
                              itemCount: cont.searchResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                MovieDetail movie = cont.searchResult[index];
                                return SearchCard(
                                  movie: movie,
                                );
                              },
                            );
                          },
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
