import 'package:filme_flix/core/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.backdropPath,
    super.releaseDate,
    required super.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? "",
      releaseDate: json['release_date'] ?? "",
      backdropPath: json['backdrop_path'] ?? "",
      overview: json['overview'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'overview': overview,
    };
  }
}
