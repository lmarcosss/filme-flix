import 'package:filme_flix/models/movie_model.dart';

sealed class TopRatedCarouselState {}

class TopRatedCarouselStateSuccess extends TopRatedCarouselState {
  final List<Movie> topRatedMovies;

  TopRatedCarouselStateSuccess({required this.topRatedMovies});
}

class TopRatedCarouselStateLoading extends TopRatedCarouselState {}

class TopRatedCarouselStateError extends TopRatedCarouselState {
  final String message;

  TopRatedCarouselStateError({required this.message});
}

class TopRatedCarouselStateInitial extends TopRatedCarouselState {}
