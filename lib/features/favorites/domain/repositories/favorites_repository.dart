import 'package:filme_flix/core/models/movie_model.dart';

abstract class FavoritesRepository {
  Future<List<MovieModel>> getFavoriteMovies();
  Future<void> addFavoriteMovie(MovieModel movie);
  Future<void> removeFavoriteMovie(MovieModel movie);
  Future<bool> isFavoriteMovie(MovieModel movie);
}
