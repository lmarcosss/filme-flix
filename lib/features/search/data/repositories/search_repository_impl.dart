import 'package:filme_flix/core/api/movie_api.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final MovieApi api;
  SearchRepositoryImpl({required this.api});

  @override
  Future<List<MovieModel>> searchMovies(String searchText, int page) async {
    return await api.searchMovies(searchText, page);
  }
}
