sealed class MovieDetailsState {}

class MovieDetailsStateSuccess extends MovieDetailsState {
  bool isFavoriteMovie;

  MovieDetailsStateSuccess({required this.isFavoriteMovie});
}

class MovieDetailsStateLoading extends MovieDetailsState {}

class MovieDetailsStateError extends MovieDetailsState {
  final String error;

  MovieDetailsStateError({required this.error});
}

class MovieDetailsStateInitial extends MovieDetailsState {}
