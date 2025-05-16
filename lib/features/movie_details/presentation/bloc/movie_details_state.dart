sealed class MovieDetailsState {}

class MovieDetailsStateSuccess extends MovieDetailsState {
  bool isFavoriteMovie;
  bool shouldReloadFavorite;

  MovieDetailsStateSuccess({
    required this.isFavoriteMovie,
    this.shouldReloadFavorite = false,
  });
}

class MovieDetailsStateLoading extends MovieDetailsState {}

class MovieDetailsStateError extends MovieDetailsState {
  final String error;

  MovieDetailsStateError({required this.error});
}

class MovieDetailsStateInitial extends MovieDetailsState {}
