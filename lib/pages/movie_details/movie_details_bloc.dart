import 'package:filme_flix/pages/favorites/favorites_bloc.dart';
import 'package:filme_flix/pages/favorites/favorites_event.dart';
import 'package:filme_flix/pages/movie_details/movie_details_event.dart';
import 'package:filme_flix/pages/movie_details/movie_details_state.dart';
import 'package:filme_flix/repositories/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  FavoriteMovieRepository favoriteMovieRepository = FavoriteMovieRepository();
  final FavoritesBloc favoritesBloc;

  MovieDetailsBloc({
    required this.favoritesBloc,
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
        await favoriteMovieRepository.isFavoriteMovie(event.movie);

    emit(MovieDetailsStateSuccess(isFavoriteMovie: isFavoriteMovieFromDb));
  }

  Future<void> _handleFavoriteMovie(
    ToggleFavoriteMovie event,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (state is MovieDetailsStateSuccess) {
      final successState = state as MovieDetailsStateSuccess;

      if (successState.isFavoriteMovie) {
        await favoriteMovieRepository.removeFavoriteMovie(event.movie);
      } else {
        await favoriteMovieRepository.addFavoriteMovie(event.movie);
      }

      emit(MovieDetailsStateSuccess(
        isFavoriteMovie: !successState.isFavoriteMovie,
      ));

      favoritesBloc.add(GetSetStateFavoriteMovies());
    }
  }
}
