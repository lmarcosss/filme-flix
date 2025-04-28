import 'package:filme_flix/components/banner/banner.dart';
import 'package:filme_flix/components/carousel/carousel.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieRepository movieRepository;

  late bool isPopularMoviesLoading = false;
  late List<Movie> popularMovies = [];

  Movie? bannerMovie;
  late bool isBannerMovieLoading = false;

  @override
  void initState() {
    movieRepository = MovieRepository();

    getBannerMovie();
    getMovies();

    super.initState();
  }

  Future<void> getBannerMovie() async {
    const String madameWebId = "634492";

    setState(() {
      isBannerMovieLoading = true;
    });

    final moviesApi = await movieRepository.getMovieDetails(madameWebId);

    if (moviesApi != null) {
      setState(() {
        bannerMovie = moviesApi;
        isBannerMovieLoading = false;
      });
    }
  }

  Future<void> getMovies() async {
    setState(() {
      isPopularMoviesLoading = true;
    });

    final moviesDb = await movieRepository.getPopularMoviesFromDb();

    if (moviesDb.isNotEmpty) {
      setState(() {
        popularMovies = moviesDb;
      });
    }

    final moviesApi = await movieRepository.getPopularMovies();

    if (moviesApi.isNotEmpty) {
      setState(() {
        popularMovies = moviesApi;
      });
    }

    setState(() {
      isPopularMoviesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        BannerMovie(
          movie: bannerMovie,
          isLoading: isBannerMovieLoading,
        ),
        Carousel(
          title: "Popular Movies",
          movies: popularMovies,
          isLoading: isPopularMoviesLoading,
        ),
      ],
    ));
  }
}
