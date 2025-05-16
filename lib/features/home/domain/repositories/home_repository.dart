import 'package:filme_flix/core/models/movie_model.dart';

abstract class HomeRepository {
  Future<Movie?> getBannerMovie(String id);

  Future<List<Movie>> getNowPlayingMovies(int page);

  Future<List<Movie>> getPopularMovies(int page);

  Future<List<Movie>> getTopRatedMovies(int page);

  Future<List<Movie>> getUpcomingMovies(int page);
}
