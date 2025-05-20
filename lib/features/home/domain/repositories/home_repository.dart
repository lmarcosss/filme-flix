import 'package:filme_flix/core/models/movie_model.dart';

abstract class HomeRepository {
  Future<MovieModel?> getBannerMovie(String id);

  Future<List<MovieModel>> getNowPlayingMovies(int page);

  Future<List<MovieModel>> getPopularMovies(int page);

  Future<List<MovieModel>> getTopRatedMovies(int page);

  Future<List<MovieModel>> getUpcomingMovies(int page);
}
