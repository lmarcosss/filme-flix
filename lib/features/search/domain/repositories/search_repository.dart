import 'package:filme_flix/core/models/movie_model.dart';

abstract class SearchRepository {
  Future<List<Movie>> searchMovies(String searchText, int page);
}
