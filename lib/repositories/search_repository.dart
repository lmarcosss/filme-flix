import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';

class SearchRepository extends MovieRepository {
  SearchRepository(super.api);

  @override
  Future<List<Movie>> searchMovies(String searchText, int page) async {
    return await super.searchMovies(searchText, page);
  }
}
