import 'package:filme_flix/models/movie_model.dart';

sealed class PopularCarouselState {}

class PopularCarouselStateSuccess extends PopularCarouselState {
  final List<Movie> popularMovies;

  PopularCarouselStateSuccess({required this.popularMovies});
}

class PopularCarouselStateLoading extends PopularCarouselState {}

class PopularCarouselStateError extends PopularCarouselState {
  final String message;

  PopularCarouselStateError({required this.message});
}

class PopularCarouselStateInitial extends PopularCarouselState {}
