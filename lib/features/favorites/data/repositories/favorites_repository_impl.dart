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
  Future<List<MovieModel>> getFavoriteMovies() async {
    final movies = storage.getStringList(key);

    if (movies == null || movies.isEmpty) {
      return [];
    }

    final formattedMovies =
        movies.map((movie) => MovieModel.fromJson(jsonDecode(movie))).toList();

    return formattedMovies;
  }

  @override
  Future<void> addFavoriteMovie(MovieModel movie) async {
    final movies = await getFavoriteMovies();
    movies.add(movie);

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  @override
  Future<void> removeFavoriteMovie(MovieModel movie) async {
    final movies = await getFavoriteMovies();
    movies.removeWhere((item) => item.id == movie.id);

    storage.setStringList(
      key,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );
  }

  @override
  Future<bool> isFavoriteMovie(MovieModel movie) async {
    final movies = await getFavoriteMovies();

    return movies.any((item) => item.id == movie.id);
  }
}
