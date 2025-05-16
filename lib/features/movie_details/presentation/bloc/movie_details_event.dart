import 'package:filme_flix/core/models/movie_model.dart';

sealed class MovieDetailsEvent {}

class GetSetStateMovieDetails extends MovieDetailsEvent {
  final Movie movie;

  GetSetStateMovieDetails({required this.movie});
}

class ToggleFavoriteMovie extends MovieDetailsEvent {
  final Movie movie;
  ToggleFavoriteMovie({required this.movie});
}
