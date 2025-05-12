import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/repositories/shared_preferences_repository.dart';
import 'package:filme_flix/widgets/banner_movie/banner_movie_event.dart';
import 'package:filme_flix/widgets/banner_movie/banner_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  HomeRepository homeRepository;
  final SharedPreferences storage = SharedPreferencesRepository.instance;

  BannerBloc({
    required this.homeRepository,
  }) : super(BannerStateInitial()) {
    on<GetSetStateBanner>(_loadSetStateBannerMovie);
  }

  Future<void> _loadSetStateBannerMovie(
    GetSetStateBanner event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerStateLoading());

    final bannerMovie = await homeRepository.getBannerMovie(event.movieId);

    if (bannerMovie == null) {
      return emit(BannerStateError(message: 'Failed to load movie details'));
    }

    emit(BannerStateSuccess(movie: bannerMovie));
  }
}
