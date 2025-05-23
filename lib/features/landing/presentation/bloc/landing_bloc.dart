import 'package:dio/dio.dart';
import 'package:filme_flix/features/landing/domain/repositories/landing_repository.dart';
import 'package:filme_flix/features/landing/presentation/bloc/landing_event.dart';
import 'package:filme_flix/features/landing/presentation/bloc/landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingRepository landingRepository;

  LandingBloc(this.landingRepository) : super(LandingStateInitial()) {
    on<GetSetStateLanding>(_loadSetStateLandingBanner);
  }

  Future<void> _loadSetStateLandingBanner(
    GetSetStateLanding event,
    Emitter<LandingState> emit,
  ) async {
    emit(LandingStateLoading());

    try {
      final movie = await landingRepository.getBannerMovie(event.movieId);

      if (movie == null) {
        throw Exception('Movie not found');
      }

      emit(LandingStateSuccess(bannerMovie: movie));
    } on DioException catch (e) {
      emit(LandingStateError(
          message: e.message ?? 'Error fetching movie details'));
    }
  }
}
