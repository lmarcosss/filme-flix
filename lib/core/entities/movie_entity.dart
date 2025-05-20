class MovieEntity {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String? releaseDate;

  MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    this.releaseDate,
    required this.overview,
  });
}
