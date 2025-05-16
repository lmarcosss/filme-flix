import 'package:filme_flix/core/models/movie_model.dart';

sealed class FavoritesState {}

class FavoritesStateSuccess extends FavoritesState {
  final List<Movie> favoriteMovies;

  FavoritesStateSuccess({required this.favoriteMovies});
}

class FavoritesStateLoading extends FavoritesState {}

class FavoritesStateError extends FavoritesState {
  final String error;

  FavoritesStateError({required this.error});
}

class FavoritesStateInitial extends FavoritesState {}
