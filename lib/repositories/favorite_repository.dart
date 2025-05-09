import 'dart:async';
import 'dart:convert';

import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMovieRepository {
  final SharedPreferences storage = SharedPreferencesRepository.instance;
  final String key = 'favoriteMovies';

  Future<List<Movie>> getFavoriteMovies() async {
    final movies = storage.getStringList(key);

    if (movies == null || movies.isEmpty) {
      return [];
    }

    final formattedMovies =
        movies.map((movie) => Movie.fromJson(jsonDecode(movie))).toList();

    return formattedMovies;
  }

  Future<void> addFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();
    movies.add(movie);

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  Future<void> removeFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();
    movies.removeWhere((item) => item.id == movie.id);

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  Future<bool> isFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();

    return movies.any((item) => item.id == movie.id);
  }
}
