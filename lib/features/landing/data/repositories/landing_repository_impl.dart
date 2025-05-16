import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/landing/domain/repositories/landing_repository.dart';
import 'package:filme_flix/shared/data/repositories/movie_repository.dart';

class LandingRepositoryImpl extends MovieRepository
    implements LandingRepository {
  LandingRepositoryImpl(super.api, super.cacheManagerService);

  @override
  Future<Movie?> getBannerMovie(String id) async {
    return super.getMovieDetails(id);
  }
}
