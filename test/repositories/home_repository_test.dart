import 'package:filme_flix/core/api/movie_api.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/home/data/repositories/home_repository_impl.dart';
import 'package:filme_flix/features/home/presentation/enums/movie_carousel_type_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MovieApiMock extends Mock implements MovieApi {}

void main() {
  late MovieApiMock movieApi;
  late HomeRepositoryImpl homeRepository;
  final page = 1;

  setUp(() {
    movieApi = MovieApiMock();
    homeRepository = HomeRepositoryImpl(api: movieApi);
  });

  group("MovieRepostory", () {
    test("getBannerMovie = success", () async {
      final movieId = "634492";
      when(() => movieApi.getMovieDetails(movieId)).thenAnswer(
        (_) async => MovieModel(
          id: 634492,
          title: "Madame Web",
          overview: "Overview",
          releaseDate: "2023-02-07",
          posterPath: "/path.jpg",
          backdropPath: "/backdrop.jpg",
        ),
      );

      final response = await homeRepository.getBannerMovie(movieId);

      expect(response, isA<MovieModel>());
    });

    test("getBannerMovie = error", () async {
      final movieId = "634492";
      when(() => movieApi.getMovieDetails(movieId)).thenThrow(Exception());

      final response = homeRepository.getBannerMovie(movieId);

      expect(response, throwsA(isA<Exception>()));
    });

    test("getPopularMovies = success", () async {
      when(() => movieApi.getMoviesByEndpoint(
          endpoint: MovieCarouselTypeEnum.popular.endpoint,
          page: page)).thenAnswer(
        (_) async => <MovieModel>[],
      );

      final response = await homeRepository.getPopularMovies(page);

      expect(response, isA<List<MovieModel>>());
    });

    test("getPopularMovies = error", () async {
      when(() => movieApi.getMoviesByEndpoint(
          endpoint: MovieCarouselTypeEnum.popular.endpoint,
          page: page)).thenThrow(Exception());

      final response = homeRepository.getPopularMovies(page);

      expect(response, throwsA(isA<Exception>()));
    });
  });
}
