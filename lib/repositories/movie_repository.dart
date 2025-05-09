import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:filme_flix/app_config.dart';
import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/cache_manager_repository.dart';

class MovieRepository {
  final Dio client = Dio(
    BaseOptions(baseUrl: AppConfig.instance.baseUrl, headers: {
      'Authorization': 'Bearer ${AppConfig.instance.apiToken}',
    }, queryParameters: {
      'language': 'en-US',
    }),
  );

  Future<List<Movie>> searchMovies(String searchText, int page) async {
    final response = await client.get("/search/movie", queryParameters: {
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

    final responseByApi = await client.get("/movie/$id");

    final movie = Movie.fromJson(responseByApi.data);

    await CacheManagerRepository.save(
      key: id,
      value: jsonEncode(movie.toJson()),
    );

    return Movie.fromJson(responseByApi.data);
  }

  Future<List<Movie>> getMoviesByEndpoint({
    required MovieCarouselTypeEnum movieType,
  }) async {
    final endpoint = movieType.endpoint;
    final response = await CacheManagerRepository.get(key: endpoint);

    if (response != null) {
      final List<dynamic> decodedData = jsonDecode(response);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }

    final responseByApi =
        await client.get("/movie/$endpoint", queryParameters: {
      'page': 1,
    });

    final movies = (responseByApi.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    await CacheManagerRepository.save(
      key: endpoint,
      value: jsonEncode(responseByApi.data['results']),
    );

    return movies;
  }
}
