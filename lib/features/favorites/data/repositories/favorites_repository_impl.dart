import 'dart:async';
import 'dart:convert';

import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  late SharedPreferences storage;
  final String key = 'favoriteMovies';

  FavoritesRepositoryImpl(this.storage);

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    final movies = storage.getStringList(key);

    if (movies == null || movies.isEmpty) {
      return [];
    }

    final formattedMovies =
        movies.map((movie) => Movie.fromJson(jsonDecode(movie))).toList();

    return formattedMovies;
  }

  @override
  Future<void> addFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();
    movies.add(movie);

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  @override
  Future<void> removeFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();
    movies.removeWhere((item) => item.id == movie.id);

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  @override
  Future<bool> isFavoriteMovie(Movie movie) async {
    final movies = await getFavoriteMovies();

    return movies.any((item) => item.id == movie.id);
  }
}
