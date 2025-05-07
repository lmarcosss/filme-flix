import 'package:filme_flix/models/movie_model.dart';

sealed class MovieCarouselState {}

class MovieCarouselStateSuccess extends MovieCarouselState {
  final List<Movie> movies;

  MovieCarouselStateSuccess({required this.movies});
}

class MovieCarouselStateLoading extends MovieCarouselState {}

class MovieCarouselStateError extends MovieCarouselState {
  final String message;

  MovieCarouselStateError({required this.message});
}

class MovieCarouselStateInitial extends MovieCarouselState {}
