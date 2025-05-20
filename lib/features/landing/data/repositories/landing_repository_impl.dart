import 'package:filme_flix/core/api/movie_api.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/landing/domain/repositories/landing_repository.dart';

class LandingRepositoryImpl implements LandingRepository {
  final MovieApi api;
  LandingRepositoryImpl({required this.api});

  @override
  Future<MovieModel?> getBannerMovie(String id) async {
    return api.getMovieDetails(id);
  }
}
