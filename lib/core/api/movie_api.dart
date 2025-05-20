import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:filme_flix/core/client/api_client.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/core/services/storage/cache_manager_service.dart';

class MovieApi {
  late ApiClient api;
  late CacheManagerService cacheManagerService;

  MovieApi({
    required this.api,
    required this.cacheManagerService,
  });

  Future<List<MovieModel>> searchMovies(String searchText, int page) async {
    try {
      final response = await api.get("/search/movie", queryParameters: {
        'page': page,
        'query': searchText,
      });

      final movies = (response.data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();

      return movies;
    } on DioException catch (_) {
      throw Exception("Isn't possible to search movies.");
    }
  }

  Future<MovieModel?> getMovieDetails(String id) async {
    try {
      final response = await cacheManagerService.get(key: id);

      if (response != null) {
        return MovieModel.fromJson((jsonDecode(response)));
      }

      final responseByApi = await api.get("/movie/$id");

      final movie = MovieModel.fromJson(responseByApi.data);

      await cacheManagerService.save(
        key: id,
        value: jsonEncode(movie.toJson()),
      );

      return MovieModel.fromJson(responseByApi.data);
    } on DioException catch (_) {
      throw Exception("Isn't possible to get movie details.");
    }
  }

  Future<List<MovieModel>> getMoviesByEndpoint({
    required String endpoint,
    required int page,
  }) async {
    try {
      final isFirstPage = page == 1;
      final response = await cacheManagerService.get(key: endpoint);

      if (response != null && isFirstPage) {
        final List<dynamic> decodedData = jsonDecode(response);

        return decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
      }

      final responseByApi = await api.get("/movie/$endpoint", queryParameters: {
        'page': page,
      });

      final movies = (responseByApi.data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();

      if (isFirstPage) {
        await cacheManagerService.save(
          key: endpoint,
          value: jsonEncode([...responseByApi.data['results']]),
        );
      }

      return movies;
    } on DioException catch (_) {
      throw Exception("Isn't possible to get movies.");
    }
  }
}
