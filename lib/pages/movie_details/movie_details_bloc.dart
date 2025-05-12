import 'package:filme_flix/pages/movie_details/movie_details_event.dart';
import 'package:filme_flix/pages/movie_details/movie_details_state.dart';
import 'package:filme_flix/repositories/favorites_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  FavoritesRepository favoritesRepository;

  MovieDetailsBloc({
    required this.favoritesRepository,
  }) : super(MovieDetailsStateInitial()) {
    on<GetSetStateMovieDetails>(_loadSetStateMovieIsFavorite);
    on<ToggleFavoriteMovie>(_handleFavoriteMovie);
  }

  Future<void> _loadSetStateMovieIsFavorite(
    GetSetStateMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsStateLoading());

    final isFavoriteMovieFromDb =
        await favoritesRepository.isFavoriteMovie(event.movie);

    emit(MovieDetailsStateSuccess(isFavoriteMovie: isFavoriteMovieFromDb));
  }

  Future<void> _handleFavoriteMovie(
    ToggleFavoriteMovie event,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (state is MovieDetailsStateSuccess) {
      final successState = state as MovieDetailsStateSuccess;

      if (successState.isFavoriteMovie) {
        await favoritesRepository.removeFavoriteMovie(event.movie);
      } else {
        await favoritesRepository.addFavoriteMovie(event.movie);
      }

      emit(MovieDetailsStateSuccess(
        isFavoriteMovie: !successState.isFavoriteMovie,
        shouldReloadFavorite: true,
      ));
    }
  }
}
