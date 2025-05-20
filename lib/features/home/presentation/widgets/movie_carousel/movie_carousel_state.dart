import 'package:filme_flix/core/models/movie_model.dart';

sealed class MovieCarouselState {}

class MovieCarouselStateSuccess extends MovieCarouselState {
  final List<MovieModel> movies;
  final int currentPage;
  final bool listIsFinished;

  MovieCarouselStateSuccess({
    required this.movies,
    this.currentPage = 1,
    this.listIsFinished = false,
  });

  MovieCarouselStateSuccess copyWith({
    List<MovieModel>? movies,
    int? currentPage,
    bool? listIsFinished,
  }) {
    return MovieCarouselStateSuccess(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      listIsFinished: listIsFinished ?? this.listIsFinished,
    );
  }
}

class MovieCarouselStateLoading extends MovieCarouselState {}

class MovieCarouselStateError extends MovieCarouselState {
  final String message;

  MovieCarouselStateError({required this.message});
}

class MovieCarouselStateInitial extends MovieCarouselState {}
