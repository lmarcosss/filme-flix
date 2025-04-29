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

  late bool isTopRatedMoviesLoading = false;
  late List<Movie> topRatedMovies = [];

  Movie? bannerMovie;
  late bool isBannerMovieLoading = false;

  @override
  void initState() {
    movieRepository = MovieRepository();

    getBannerMovie();
    getPopularMovies();
    getTopRatedMovies();

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

  Future<void> getPopularMovies() async {
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

  Future<void> getTopRatedMovies() async {
    setState(() {
      isTopRatedMoviesLoading = true;
    });

    final moviesApi = await movieRepository.getTopRatedMovies();

    if (moviesApi.isNotEmpty) {
      setState(() {
        topRatedMovies = moviesApi;
      });
    }

    setState(() {
      isTopRatedMoviesLoading = false;
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
        Carousel(
          title: "Top Rated Movies",
          movies: topRatedMovies,
          isLoading: isTopRatedMoviesLoading,
        ),
      ],
    ));
  }
}
