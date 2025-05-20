import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/core/injection/locator.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/core/utils/date_formatter.dart';
import 'package:filme_flix/core/utils/image_imdb.dart';
import 'package:filme_flix/core/widgets/header/header_widget.dart';
import 'package:filme_flix/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:filme_flix/features/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:filme_flix/features/movie_details/presentation/bloc/movie_details_event.dart';
import 'package:filme_flix/features/movie_details/presentation/bloc/movie_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatefulWidget {
  static const String route = "/movie-details";
  final MovieModel movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late FavoritesRepository favoritesRepository;
  late FavoritesBloc favoritesBloc;
  late MovieDetailsBloc movieDetailsBloc;
  late MovieModel movie = widget.movie;
  late StreamSubscription<MovieDetailsState> streamSubscription;

  @override
  void initState() {
    super.initState();

    favoritesBloc = getIt<FavoritesBloc>();
    favoritesRepository = getIt<FavoritesRepository>();
    movieDetailsBloc =
        MovieDetailsBloc(favoritesRepository: favoritesRepository);
    streamSubscription = movieDetailsBloc.stream.listen(handleState);

    movieDetailsBloc.add(GetSetStateMovieDetails(movie: movie));
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    movieDetailsBloc.close();
    super.dispose();
  }

  void handleState(MovieDetailsState state) {
    if (state case MovieDetailsStateSuccess(:final shouldReloadFavorite)) {
      if (shouldReloadFavorite) {
        favoritesBloc.add(GetSetStateFavoriteMovies());
      }
    }
  }

  void onToggleFavorite() {
    movieDetailsBloc.add(ToggleFavoriteMovie(movie: movie));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
            title: movie.title,
            rightIcon: IconButton(
              onPressed: onToggleFavorite,
              icon: BlocBuilder(
                bloc: movieDetailsBloc,
                builder: (context, state) {
                  return switch (state) {
                    MovieDetailsStateSuccess() => Icon(
                        state.isFavoriteMovie
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            )),
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
