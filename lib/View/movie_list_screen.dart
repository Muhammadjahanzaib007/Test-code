import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test_project/Controllers/movies_controller.dart';
import 'package:test_project/View/Widgets/movie_card.dart';

import '../Models/upcoming_movies.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviesController>(
        autoRemove: false,
        init: MoviesController(),
        builder: (cont) => cont.isLoading || cont.upcomingmovies == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 1 : 2,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        MovieDetail movie =
                            cont.upcomingmovies!.results![index];
                        return MoviesCard(
                          movie: movie,
                        );
                      },
                    );
                  },
                ),
              )
    );
  }
}
