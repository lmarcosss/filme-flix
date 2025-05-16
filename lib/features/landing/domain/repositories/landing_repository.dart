import 'package:filme_flix/core/models/movie_model.dart';

abstract class LandingRepository {
  Future<Movie?> getBannerMovie(String id);
}
