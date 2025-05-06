import 'package:filme_flix/pages/home/widgets/banner/banner_event.dart';
import 'package:filme_flix/pages/home/widgets/banner/banner_state.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:filme_flix/repositories/shared_preferences_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  MovieRepository movieRepository = MovieRepository();
  final SharedPreferences storage = SharedPreferencesRepository.instance;

  BannerBloc() : super(BannerStateInitial()) {
    on<GetSetStateBanner>(_loadSetStateBannerMovie);
  }

  Future<void> _loadSetStateBannerMovie(
    GetSetStateBanner event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerStateLoading());

    final bannerMovie = await movieRepository.getMovieDetails(event.movieId);

    if (bannerMovie == null) {
      emit(BannerStateError(message: 'Failed to load movie details'));
      return;
    }

    emit(BannerStateSuccess(movie: bannerMovie));
  }
}
