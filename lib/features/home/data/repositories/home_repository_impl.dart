import 'package:filme_flix/core/api/movie_api.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/home/domain/repositories/home_repository.dart';
import 'package:filme_flix/features/home/presentation/enums/movie_carousel_type_enum.dart';

class HomeRepositoryImpl implements HomeRepository {
  final MovieApi api;
  HomeRepositoryImpl({required this.api});

  @override
  Future<MovieModel?> getBannerMovie(String id) async {
    return api.getMovieDetails(id);
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    return api.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.nowPlaying.endpoint,
      page: page,
    );
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    return api.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.popular.endpoint,
      page: page,
    );
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies(int page) async {
    return api.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.topRated.endpoint,
      page: page,
    );
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies(int page) async {
    return api.getMoviesByEndpoint(
      endpoint: MovieCarouselTypeEnum.upcoming.endpoint,
      page: page,
    );
  }
}
