import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';

class HomeRepository extends MovieRepository {
  HomeRepository(super.api);

  Future<Movie?> getBannerMovie(String id) async {
    return super.getMovieDetails(id);
  }

  Future<List<Movie>> getNowPlayingMovies(int page) async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.nowPlaying,
      page: page,
    );
  }

  Future<List<Movie>> getPopularMovies(int page) async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.popular,
      page: page,
    );
  }

  Future<List<Movie>> getTopRatedMovies(int page) async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.topRated,
      page: page,
    );
  }

  Future<List<Movie>> getUpcomingMovies(int page) async {
    return super.getMoviesByEndpoint(
      movieType: MovieCarouselTypeEnum.upcoming,
      page: page,
    );
  }
}
