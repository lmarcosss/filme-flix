import 'package:filme_flix/core/models/movie_model.dart';

abstract class FavoritesRepository {
  Future<List<Movie>> getFavoriteMovies();
  Future<void> addFavoriteMovie(Movie movie);
  Future<void> removeFavoriteMovie(Movie movie);
  Future<bool> isFavoriteMovie(Movie movie);
}
