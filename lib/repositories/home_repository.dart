import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';

class HomeRepository extends MovieRepository {
  Future<Movie?> getBannerMovie(String id) async {
    return super.getMovieDetails(id);
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.nowPlaying,
    );
  }

  Future<List<Movie>> getPopularMovies() async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.popular,
    );
  }

  Future<List<Movie>> getTopRatedMovies() async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.topRated,
    );
  }

  Future<List<Movie>> getUpcomingMovies() async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.upcoming,
    );
  }
}
