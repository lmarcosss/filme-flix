import 'package:filme_flix/components/carousel/carousel.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Inception',
    posterPath:
        'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
  ),
  Movie(
    id: 2,
    title: 'Dune',
    posterPath:
        'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
  ),
  Movie(
    id: 3,
    title: 'Openheimer',
    posterPath:
        'https://image.tmdb.org/t/p/w500/ptpr0kGAckfQkJeJIt8st5dglvd.jpg',
  ),
  Movie(
    id: 4,
    title: 'Batman',
    posterPath:
        'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
  ),
];

class HomePage extends StatefulWidget {
  static const String route = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieRepository movieRepository;
  late List<Movie> movies = [];

  @override
  void initState() {
    movieRepository = MovieRepository();

    getMovies();

    super.initState();
  }

  Future<void> getMovies() async {
    final moviesDb = await movieRepository.getPopularMoviesFromDb();

    if (moviesDb.isNotEmpty) {
      setState(() {
        movies = moviesDb;
      });
    }

    final moviesApi = await movieRepository.getPopularMovies();

    if (moviesApi.isNotEmpty) {
      setState(() {
        movies = moviesApi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Image.asset(
          "assets/images/madame_web.png",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Carousel(title: "Populares Movies", movies: movies),
      ],
    ));
  }
}
