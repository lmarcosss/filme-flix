import 'package:filme_flix/get_it_config.dart';
import 'package:filme_flix/pages/favorites/favorites_bloc.dart';
import 'package:filme_flix/repositories/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget globalProvider({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<FavoritesBloc>(
        create: (_) => FavoritesBloc(
          favoritesRepository: getIt<FavoritesRepository>(),
        ),
      ),
    ],
    child: child,
  );
}
