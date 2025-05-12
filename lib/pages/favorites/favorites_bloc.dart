import 'package:filme_flix/pages/favorites/favorites_event.dart';
import 'package:filme_flix/pages/favorites/favorites_state.dart';
import 'package:filme_flix/repositories/favorites_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesRepository favoritesRepository;
  FavoritesBloc({
    required this.favoritesRepository,
  }) : super(FavoritesStateInitial()) {
    on<GetSetStateFavoriteMovies>(_loadSetStateFavoriteMovies);
  }

  Future<void> _loadSetStateFavoriteMovies(
    GetSetStateFavoriteMovies event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesStateLoading());

    final favoriteMovies = await favoritesRepository.getFavoriteMovies();

    emit(FavoritesStateSuccess(favoriteMovies: favoriteMovies));
  }
}
