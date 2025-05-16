import 'package:filme_flix/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:filme_flix/features/movie_details/presentation/bloc/movie_details_event.dart';
import 'package:filme_flix/features/movie_details/presentation/bloc/movie_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  FavoritesRepositoryImpl favoritesRepository;

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
