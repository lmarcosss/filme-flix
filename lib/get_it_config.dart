import 'package:filme_flix/pages/favorites/favorites_bloc.dart';
import 'package:filme_flix/repositories/favorites_repository.dart';
import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/repositories/landing_repository.dart';
import 'package:filme_flix/repositories/search_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> getItConfig() async {
  // Services
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Repositories
  getIt.registerFactory<HomeRepository>(() => HomeRepository());
  getIt.registerFactory<FavoritesRepository>(() => FavoritesRepository());
  getIt.registerFactory<SearchRepository>(() => SearchRepository());
  getIt.registerFactory<LandingRepository>(() => LandingRepository());

  // Blocs
  getIt.registerSingleton(FavoritesBloc(getIt<FavoritesRepository>()));
}
