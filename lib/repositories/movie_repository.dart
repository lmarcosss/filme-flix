import 'dart:async';
import 'dart:convert';

import 'package:filme_flix/client/api_client.dart';
import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/cache_manager_repository.dart';

class MovieRepository {
  late ApiClient api;

  MovieRepository(this.api);

  Future<List<Movie>> searchMovies(String searchText, int page) async {
    final response = await api.get("/search/movie", queryParameters: {
      'page': page,
      'query': searchText,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }

  Future<Movie?> getMovieDetails(String id) async {
    final response = await CacheManagerRepository.get(key: id);

    if (response != null) {
      return Movie.fromJson((jsonDecode(response)));
    }

    final responseByApi = await api.get("/movie/$id");

    final movie = Movie.fromJson(responseByApi.data);

    await CacheManagerRepository.save(
      key: id,
      value: jsonEncode(movie.toJson()),
    );

    return Movie.fromJson(responseByApi.data);
  }

  Future<List<Movie>> getMoviesByEndpoint({
    required MovieCarouselTypeEnum movieType,
    required int page,
  }) async {
    final endpoint = movieType.endpoint;
    final response = await CacheManagerRepository.get(key: endpoint);
    final previousPage =
        await CacheManagerRepository.get(key: "page-$endpoint");

    if (response != null &&
        previousPage != null &&
        int.parse(previousPage) <= page) {
      final List<dynamic> decodedData = jsonDecode(response);

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }

    final responseByApi = await api.get("/movie/$endpoint", queryParameters: {
      'page': page,
    });

    final movies = (responseByApi.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    await CacheManagerRepository.save(
      key: endpoint,
      value: jsonEncode([...responseByApi.data['results']]),
    );

    await CacheManagerRepository.save(
      key: "page-$endpoint",
      value: jsonEncode(page),
    );

    return movies;
  }
}
