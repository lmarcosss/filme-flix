import 'package:filme_flix/repositories/favorites_repository.dart';
import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/repositories/search_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void getItConfig() {
  getIt.registerSingleton<HomeRepository>(HomeRepository());
  getIt.registerFactory<FavoritesRepository>(() => FavoritesRepository());
  getIt.registerFactory<SearchRepository>(() => SearchRepository());
}
