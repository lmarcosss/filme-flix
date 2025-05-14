import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';

class LandingRepository extends MovieRepository {
  LandingRepository(super.api);

  Future<Movie?> getBannerMovie(String id) async {
    return super.getMovieDetails(id);
  }
}
