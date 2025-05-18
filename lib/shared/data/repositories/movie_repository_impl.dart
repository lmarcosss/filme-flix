import 'dart:async';
import 'dart:convert';

import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/core/network/api_client.dart';
import 'package:filme_flix/core/services/storage/cache_manager_service.dart';

class MovieRepositoryImpl {
  late ApiClient api;
  late CacheManagerService cacheManagerService;

  MovieRepositoryImpl(this.api, this.cacheManagerService);

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
    final response = await cacheManagerService.get(key: id);

    if (response != null) {
      return Movie.fromJson((jsonDecode(response)));
    }

    final responseByApi = await api.get("/movie/$id");

    final movie = Movie.fromJson(responseByApi.data);

    await cacheManagerService.save(
      key: id,
      value: jsonEncode(movie.toJson()),
    );

    return Movie.fromJson(responseByApi.data);
  }

  Future<List<Movie>> getMoviesByEndpoint({
    required String endpoint,
    required int page,
  }) async {
    final isFirstPage = page == 1;
    final response = await cacheManagerService.get(key: endpoint);

    if (response != null && isFirstPage) {
      final List<dynamic> decodedData = jsonDecode(response);

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }

    final responseByApi = await api.get("/movie/$endpoint", queryParameters: {
      'page': page,
    });

    final movies = (responseByApi.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    if (isFirstPage) {
      await cacheManagerService.save(
        key: endpoint,
        value: jsonEncode([...responseByApi.data['results']]),
      );
    }

    return movies;
  }
}
