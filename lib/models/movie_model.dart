class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String? releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    this.releaseDate,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
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

  static String getImageUrl(String path) {
    return "https://image.tmdb.org/t/p/original$path";
  }
}
