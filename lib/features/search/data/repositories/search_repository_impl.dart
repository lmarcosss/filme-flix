import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/search/domain/repositories/search_repository.dart';
import 'package:filme_flix/shared/data/repositories/movie_repository.dart';

class SearchRepositoryImpl extends MovieRepository implements SearchRepository {
  SearchRepositoryImpl(super.api, super.cacheManagerService);

  @override
  Future<List<Movie>> searchMovies(String searchText, int page) async {
    return await super.searchMovies(searchText, page);
  }
}
