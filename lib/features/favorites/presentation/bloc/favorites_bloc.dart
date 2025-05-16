import 'package:filme_flix/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesRepository favoritesRepository;
  FavoritesBloc(this.favoritesRepository) : super(FavoritesStateInitial()) {
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
