import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/components/movie/movie_item.dart';
import 'package:filme_flix/components/movie/movie_item_loader.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  static const String route = "/favorites";
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<Movie> favoriteMovies = [];
  late bool isLoading = true;
  late FavoriteMovieRepository favoriteMovieRepository;

  @override
  void initState() {
    super.initState();
    favoriteMovieRepository = FavoriteMovieRepository();

    getFavoriteMovies();
  }

  Future<void> getFavoriteMovies() async {
    setState(() {
      isLoading = true;
    });

    favoriteMovies = await favoriteMovieRepository.getFavoriteMovies();

    setState(() {
      favoriteMovies = favoriteMovies;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(title: "Favorites"),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];

                if (isLoading) {
                  return const MovieItemLoader();
                }

                if (!isLoading && movie.posterPath.isEmpty) {
                  return SizedBox.shrink();
                }

                return MovieItem(movie: movie);
              },
            ),
          )
        ]));
  }
}
