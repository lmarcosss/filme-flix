import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:filme_flix/app_config.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieRepository {
  final Dio client = Dio(
    BaseOptions(baseUrl: AppConfig.instance.baseUrl, headers: {
      'Authorization': 'Bearer ${AppConfig.instance.apiToken}',
    }, queryParameters: {
      'language': 'pt-BR',
    }),
  );

  SharedPreferences? _preferences;
  final String popularMoviesKey = 'popular_movies';

  FutureOr<SharedPreferences> get db async {
    _preferences ??= await SharedPreferences.getInstance();

    return _preferences!;
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await client.get("/discover/movie", queryParameters: {
      'page': 1,
    });

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    final storage = await db;

    storage.setStringList(
      popularMoviesKey,
      movies.map((movie) => jsonEncode(movie.toJson())).toList(),
    );

    return movies;
  }

  Future<List<Movie>> getPopularMoviesFromDb() async {
    final storage = await db;

    final movies = storage.getStringList(popularMoviesKey);

    if (movies == null || movies.isEmpty) {
      return [];
    }

    return movies.map((movie) => Movie.fromJson(jsonDecode(movie))).toList();
  }
}
