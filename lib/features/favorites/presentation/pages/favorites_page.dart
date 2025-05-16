import 'package:filme_flix/core/di/get_it_config.dart';
import 'package:filme_flix/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:filme_flix/shared/widgets/header/header_widget.dart';
import 'package:filme_flix/shared/widgets/movie_item/movie_item_loader_widget.dart';
import 'package:filme_flix/shared/widgets/movie_item/movie_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  static const String route = "/favorites";
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesRepositoryImpl favoritesRepository;
  late FavoritesBloc favoritesBloc;

  @override
  void initState() {
    super.initState();
    favoritesRepository = getIt<FavoritesRepositoryImpl>();
    favoritesBloc = getIt<FavoritesBloc>();

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
