import 'package:filme_flix/core/models/movie_model.dart';

sealed class SearchState {}

class SearchStateSuccess extends SearchState {
  List<Movie> searchResult;
  int currentPage;
  bool listIsFinished;

  SearchStateSuccess({
    required this.searchResult,
    required this.currentPage,
    this.listIsFinished = false,
  });

  SearchStateSuccess copyWith({
    List<Movie>? searchResult,
    int? currentPage,
    bool? listIsFinished,
  }) {
    return SearchStateSuccess(
      searchResult: searchResult ?? this.searchResult,
      currentPage: currentPage ?? this.currentPage,
      listIsFinished: listIsFinished ?? this.listIsFinished,
    );
  }
}

class SearchStateLoading extends SearchState {}

class SearchStateError extends SearchState {
  final String error;

  SearchStateError({required this.error});
}

class SearchStateInitial extends SearchState {
  List<Movie> searchResult = [];
}
