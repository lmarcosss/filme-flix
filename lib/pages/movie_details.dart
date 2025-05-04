import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/favorites/favorites_bloc.dart';
import 'package:filme_flix/pages/favorites/favorites_event.dart';
import 'package:filme_flix/repositories/favorite_repository.dart';
import 'package:filme_flix/utils/date_formatter.dart';
import 'package:filme_flix/utils/image_imdb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatefulWidget {
  static const String route = "/movie-details";
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late FavoriteMovieRepository favoriteMovieRepository;
  late FavoritesBloc favoritesBloc;
  late bool isFavoriteMovie = false;
  late Movie movie;

  @override
  void initState() {
    super.initState();

    favoritesBloc = context.read<FavoritesBloc>();
    favoriteMovieRepository = FavoriteMovieRepository();
    movie = widget.movie;

    verifyIfMovieIsFavorite();
  }

  Future<void> verifyIfMovieIsFavorite() async {
    final isFavoriteMovieFromDb =
        await favoriteMovieRepository.isFavoriteMovie(movie);

    setState(() {
      isFavoriteMovie = isFavoriteMovieFromDb;
    });
  }

  Future<void> handleFavoriteMovie() async {
    if (isFavoriteMovie) {
      await favoriteMovieRepository.removeFavoriteMovie(movie);
    } else {
      await favoriteMovieRepository.addFavoriteMovie(movie);
    }

    favoritesBloc.add(GetSetStateFavoriteMovies());

    setState(() {
      isFavoriteMovie = !isFavoriteMovie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
          title: movie.title,
          rightIcon: IconButton(
            onPressed: handleFavoriteMovie,
            icon: Icon(
              isFavoriteMovie ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 220,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: ImageTmdb.getImageUrl(
                    movie.backdropPath.isNotEmpty
                        ? movie.backdropPath
                        : movie.posterPath,
                    size: ImageTmdb.w500),
                placeholder: (context, url) {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade900,
                      highlightColor: Colors.grey.shade800,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      movie.releaseDate!.isNotEmpty
                          ? DateFormatter.getYearFromStringDate(
                              movie.releaseDate!)
                          : "Unknown",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(movie.overview,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                        )),
                  ],
                ))
          ],
        ));
  }
}
