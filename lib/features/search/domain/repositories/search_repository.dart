import 'package:filme_flix/core/models/movie_model.dart';

abstract class SearchRepository {
  Future<List<MovieModel>> searchMovies(String searchText, int page);
}
