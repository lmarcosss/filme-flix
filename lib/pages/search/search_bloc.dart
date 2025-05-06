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
    if (event.query.isNotEmpty) {
      emit(SearchStateLoading());

      final moviesSearched = await movieRepository.searchMovies(event.query);

      emit(SearchStateSuccess(searchResult: moviesSearched));
    } else {
      emit(SearchStateInitial());
    }
  }
}
