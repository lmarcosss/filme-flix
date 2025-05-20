import 'package:filme_flix/core/api/movie_api.dart';
import 'package:filme_flix/core/client/api_client.dart';
import 'package:filme_flix/core/services/storage/cache_manager_service.dart';
import 'package:filme_flix/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:filme_flix/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:filme_flix/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:filme_flix/features/home/data/repositories/home_repository_impl.dart';
import 'package:filme_flix/features/home/domain/repositories/home_repository.dart';
import 'package:filme_flix/features/landing/data/repositories/landing_repository_impl.dart';
import 'package:filme_flix/features/landing/domain/repositories/landing_repository.dart';
import 'package:filme_flix/features/search/data/repositories/search_repository_impl.dart';
import 'package:filme_flix/features/search/domain/repositories/search_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerLazySingleton(
    () => ApiClient(),
  );

  getIt.registerLazySingleton(
    () => CacheManagerService(getIt<SharedPreferences>()),
  );

  getIt.registerFactory(
    () => MovieApi(
      api: getIt<ApiClient>(),
      cacheManagerService: getIt<CacheManagerService>(),
    ),
  );

  // Repositories
  getIt.registerFactory<LandingRepository>(
    () => LandingRepositoryImpl(api: getIt<MovieApi>()),
  );

  getIt.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(api: getIt<MovieApi>()),
  );

  getIt.registerFactory<SearchRepository>(
    () => SearchRepositoryImpl(api: getIt<MovieApi>()),
  );

  getIt.registerFactory<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt<SharedPreferences>()),
  );

  // Blocs
  getIt.registerLazySingleton(
    () => FavoritesBloc(getIt<FavoritesRepository>()),
  );
}
