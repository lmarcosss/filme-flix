import 'dart:async';
import 'dart:convert';

import 'package:filme_flix/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMovieRepository {
  SharedPreferences? _preferences;
  final String key = 'favoriteMovies';

  FutureOr<SharedPreferences> get db async {
    _preferences ??= await SharedPreferences.getInstance();

    return _preferences!;
  }

  Future<List<Movie>> getFavoriteMovies() async {
    final storage = await db;

    final movies = storage.getStringList(key);

    if (movies == null || movies.isEmpty) {
      return [];
    }

    return movies.map((movie) => Movie.fromJson(jsonDecode(movie))).toList();
  }

  Future<void> addFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();
    movies.add(movie);

    final storage = await db;

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  Future<void> removeFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();
    movies.removeWhere((item) => item.id == movie.id);

    final storage = await db;

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
