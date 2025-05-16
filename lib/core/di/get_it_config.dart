import 'package:filme_flix/core/network/api_client.dart';
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

Future<void> getItConfig() async {
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

  // Repositories
  getIt.registerFactory<LandingRepository>(
    () =>
        LandingRepositoryImpl(getIt<ApiClient>(), getIt<CacheManagerService>()),
  );

  getIt.registerFactory<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt<SharedPreferences>()),
  );

  getIt.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(getIt<ApiClient>(), getIt<CacheManagerService>()),
  );

  getIt.registerFactory<SearchRepository>(
    () =>
        SearchRepositoryImpl(getIt<ApiClient>(), getIt<CacheManagerService>()),
  );

  // Blocs
  getIt.registerLazySingleton(
    () => FavoritesBloc(getIt<FavoritesRepository>()),
  );
}
