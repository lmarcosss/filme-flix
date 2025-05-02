import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:filme_flix/app_config.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/app_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieRepository {
  final Dio client = Dio(
    BaseOptions(baseUrl: AppConfig.instance.baseUrl, headers: {
      'Authorization': 'Bearer ${AppConfig.instance.apiToken}',
    }, queryParameters: {
      'language': 'en-US',
    }),
  );

  final SharedPreferences storage = AppSharedPreferencesRepository.instance;
  final String popularMoviesKey = 'popular_movies';

  Future<List<Movie>> getPopularMovies() async {
    final response = await client.get("/discover/movie", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    storage.setStringList(
      popularMoviesKey,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );

    return movies;
  }

  Future<List<Movie>> getPopularMoviesFromDb() async {
    final movies = storage.getStringList(popularMoviesKey);

    if (movies == null || movies.isEmpty) {
      return [];
    }

    return movies.map((movie) => Movie.fromJson(jsonDecode(movie))).toList();
  }

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

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await client.get("/movie/top_rated", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }
}
