import 'package:filme_flix/models/movie_model.dart';

sealed class FavoritesEvent {}

class GetSetStateFavoriteMovies extends FavoritesEvent {
  final List<Movie>? favoriteMovies;

  GetSetStateFavoriteMovies({
    this.favoriteMovies,
  });
}
