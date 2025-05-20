import 'package:filme_flix/core/models/movie_model.dart';

sealed class MovieDetailsEvent {}

class GetSetStateMovieDetails extends MovieDetailsEvent {
  final MovieModel movie;

  GetSetStateMovieDetails({required this.movie});
}

class ToggleFavoriteMovie extends MovieDetailsEvent {
  final MovieModel movie;
  ToggleFavoriteMovie({required this.movie});
}
