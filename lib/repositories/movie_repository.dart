import 'package:dio/dio.dart';
import 'package:filme_flix/app_config.dart';
import 'package:filme_flix/models/movie_model.dart';

class MovieRepository {
  final Dio client = Dio(
    BaseOptions(baseUrl: AppConfig.instance.baseUrl, headers: {
      'Authorization': 'Bearer ${AppConfig.instance.apiToken}',
    }, queryParameters: {
      'language': 'pt-BR',
    }),
  );

  Future<List<Movie>> getMovies() async {
    final response = await client.get("/discover/movie", queryParameters: {
      'page': 1,
    });

    return response.data['results']
        .map<Movie>((movie) => Movie.fromJson(movie))
        .toList()
        .cast<Movie>();
  }
}
