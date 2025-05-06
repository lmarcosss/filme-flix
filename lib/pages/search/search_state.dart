import 'package:filme_flix/models/movie_model.dart';

sealed class SearchState {}

class SearchStateSuccess extends SearchState {
  List<Movie> searchResult;

  SearchStateSuccess({required this.searchResult});
}

class SearchStateLoading extends SearchState {}

class SearchStateError extends SearchState {
  final String error;

  SearchStateError({required this.error});
}

class SearchStateInitial extends SearchState {
  List<Movie> searchResult = [];
}
