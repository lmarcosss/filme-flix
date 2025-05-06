import 'package:filme_flix/pages/landing/landing_event.dart';
import 'package:filme_flix/pages/landing/landing_state.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  MovieRepository movieRepository = MovieRepository();

  LandingBloc() : super(LandingStateInitial()) {
    on<GetSetStateLanding>(_loadSetStateLandingBanner);
  }

  Future<void> _loadSetStateLandingBanner(
    GetSetStateLanding event,
    Emitter<LandingState> emit,
  ) async {
    emit(LandingStateLoading());

    final movie = await movieRepository.getMovieDetails(event.movieId);

    if (movie == null) {
      emit(LandingStateError(error: 'Movie not found'));
      return;
    }

    emit(LandingStateSuccess(bannerMovie: movie));
  }
}
