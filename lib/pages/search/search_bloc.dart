import 'package:filme_flix/pages/search/search_event.dart';
import 'package:filme_flix/pages/search/search_state.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  MovieRepository movieRepository = MovieRepository();

  SearchBloc() : super(SearchStateInitial()) {
    on<GetSetStateSearch>(_loadSetStateSearch);
  }

  Future<void> _loadSetStateSearch(
    GetSetStateSearch event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      return emit(SearchStateInitial());
    }

    final currentState = state;

    if (event.isLoadMore && currentState is SearchStateSuccess) {
      if (currentState.listIsFinished) {
        return;
      }

      final newResults = await movieRepository.searchMovies(
        event.query,
        currentState.currentPage + 1,
      );

      if (newResults.isEmpty) {
        return emit(currentState.copyWith(listIsFinished: true));
      }

      return emit(currentState.copyWith(
        searchResult: [...currentState.searchResult, ...newResults],
        currentPage: currentState.currentPage + 1,
      ));
    }

    emit(SearchStateLoading());

    final results = await movieRepository.searchMovies(event.query, 1);

    emit(SearchStateSuccess(
      searchResult: results,
      currentPage: 1,
    ));
  }
}
