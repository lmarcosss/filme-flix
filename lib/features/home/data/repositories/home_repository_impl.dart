import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/home/domain/repositories/home_repository.dart';
import 'package:filme_flix/features/home/presentation/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/shared/data/repositories/movie_repository.dart';

class HomeRepositoryImpl extends MovieRepository implements HomeRepository {
  HomeRepositoryImpl(super.api, super.cacheManagerService);

  @override
  Future<Movie?> getBannerMovie(String id) async {
    return super.getMovieDetails(id);
  }

  @override
  Future<List<Movie>> getNowPlayingMovies(int page) async {
    return super.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.nowPlaying.endpoint,
      page: page,
    );
  }

  @override
  Future<List<Movie>> getPopularMovies(int page) async {
    return super.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.popular.endpoint,
      page: page,
    );
  }

  @override
  Future<List<Movie>> getTopRatedMovies(int page) async {
    return super.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.topRated.endpoint,
      page: page,
    );
  }

  @override
  Future<List<Movie>> getUpcomingMovies(int page) async {
    return super.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.upcoming.endpoint,
      page: page,
    );
  }
}
