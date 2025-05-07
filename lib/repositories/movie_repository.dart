import 'dart:async';

import 'package:dio/dio.dart';
import 'package:filme_flix/app_config.dart';
import 'package:filme_flix/models/movie_model.dart';

class MovieRepository {
  final Dio client = Dio(
    BaseOptions(baseUrl: AppConfig.instance.baseUrl, headers: {
      'Authorization': 'Bearer ${AppConfig.instance.apiToken}',
    }, queryParameters: {
      'language': 'en-US',
    }),
  );

  Future<List<Movie>> searchMovies(String searchText) async {
    final response = await client.get("/search/movie", queryParameters: {
      'page': 1,
      'query': searchText,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }

  Future<Movie?> getMovieDetails(String id) async {
    final response = await client.get("/movie/$id");

    return Movie.fromJson(response.data);
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await client.get("/movie/now_playing", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await client.get("/movie/popular", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await client.get("/movie/top_rated", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await client.get("/movie/upcoming", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }
}
