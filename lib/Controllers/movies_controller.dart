
import 'package:get/get.dart';
import 'package:test_project/Models/movie_video_model.dart';
import 'package:test_project/Models/upcoming_movies.dart';
import 'package:test_project/utils/tmdb_api_key.dart';

import '../Api Service/api_client.dart';


class MoviesController extends GetxController {
  ApiClient apiclient = ApiClient();
  Rx<UpcomingMovies>? upcomingmoviesResult;
  UpcomingMovies? get upcomingmovies=> upcomingmoviesResult?.value;
  RxList<MovieVideo> movieVideos = RxList<MovieVideo>([]);
  RxList<MovieDetail> searchResult = RxList<MovieDetail>([]);
  Map<String,dynamic> geners = {};
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    getUpcomingMovies();
    getGenres();
    super.onInit();
  }

  Future getUpcomingMovies() async {
    isLoading = true;
    update();
    Response response =
    await apiclient.getData("/movie/upcoming", query: {
      'api_key': tmdbApiKey,
    });
    Map<String, dynamic> data = response.body;
    upcomingmoviesResult = UpcomingMovies.fromJson(data).obs;
    update();
    isLoading = false;
    update();
  }
  Future getGenres() async {
    isLoading = true;
    update();
    Response response =
    await apiclient.getData("/genre/movie/list", query: {
      'api_key': tmdbApiKey,
    });
    Map<String, dynamic> data = response.body;
    List<dynamic> genrelist = data['genres'];
    var map1 = { for (var e in genrelist) e['id'].toString() : e['name'] };
    geners = map1;
    isLoading = false;
    update();
  }
  Future getVideos(int id) async {
    isLoading = true;
    update();
    Response response =
    await apiclient.getData("/movie/$id/videos", query: {
      'api_key': tmdbApiKey,
    });
    Map<String, dynamic> data = response.body;
    if (data['results'] != null) {
      movieVideos = <MovieVideo>[].obs;
      data['results'].forEach((v) {
        movieVideos.add( MovieVideo.fromJson(v));
      });
    }
    isLoading = false;
    update();
  }
  Future searchMovies(String text) async {
    isLoading = true;
    update();
    Response response =
    await apiclient.getData("/search/movie", query: {
      'api_key': tmdbApiKey,
      'query': text,
    });
    Map<String, dynamic> data = response.body;
    if (data['results'] != null) {
      searchResult = <MovieDetail>[].obs;
      data['results'].forEach((v) {
        searchResult.add( MovieDetail.fromJson(v));
      });
    }
    isLoading = false;
    update();
  }
}