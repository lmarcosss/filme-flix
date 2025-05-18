import 'dart:async';

import 'package:filme_flix/core/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies(String searchText, int page);

  Future<Movie?> getMovieDetails(String id);

  Future<List<Movie>> getMoviesByEndpoint({
    required String endpoint,
    required int page,
  });
}
