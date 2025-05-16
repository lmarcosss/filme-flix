import 'package:filme_flix/api/api_client.dart';
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

  getIt.registerLazySingleton(
    () => ApiClient(),
  );

  // Repositories
  getIt.registerFactory<HomeRepository>(
    () => HomeRepository(getIt<ApiClient>()),
  );

  getIt.registerFactory<LandingRepository>(
    () => LandingRepository(getIt<ApiClient>()),
  );

  getIt.registerFactory<FavoritesRepository>(
    () => FavoritesRepository(getIt<SharedPreferences>()),
  );

  getIt.registerFactory<SearchRepository>(
    () => SearchRepository(getIt<ApiClient>()),
  );

  // Blocs
  getIt.registerLazySingleton(
    () => FavoritesBloc(getIt<FavoritesRepository>()),
  );
}
