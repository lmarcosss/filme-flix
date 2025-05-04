import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/components/movie/movie_item.dart';
import 'package:filme_flix/components/movie/movie_item_loader.dart';
import 'package:filme_flix/pages/favorites/favorites_bloc.dart';
import 'package:filme_flix/pages/favorites/favorites_event.dart';
import 'package:filme_flix/pages/favorites/favorites_state.dart';
import 'package:filme_flix/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  static const String route = "/favorites";
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoriteMovieRepository favoriteMovieRepository;
  late FavoritesBloc favoritesBloc;

  @override
  void initState() {
    super.initState();
    favoriteMovieRepository = FavoriteMovieRepository();
    favoritesBloc = context.read<FavoritesBloc>();

    favoritesBloc.add(GetSetStateFavoriteMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Favorites"),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              bloc: favoritesBloc,
              builder: (context, state) {
                return switch (state) {
                  FavoritesStateLoading() => const MovieItemLoader(),
                  FavoritesStateError() => const Center(
                      child: Text("Error to loading favorite movies"),
                    ),
                  FavoritesStateSuccess() => ListView.builder(
                      itemCount: (state.favoriteMovies.length),
                      itemBuilder: (context, index) {
                        final movie = state.favoriteMovies[index];

                        return MovieItem(movie: movie);
                      },
                    ),
                  FavoritesStateInitial() => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
