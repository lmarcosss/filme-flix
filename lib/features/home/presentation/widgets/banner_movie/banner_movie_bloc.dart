import 'package:dio/dio.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/home/domain/repositories/home_repository.dart';
import 'package:filme_flix/features/home/presentation/widgets/banner_movie/banner_movie_event.dart';
import 'package:filme_flix/features/home/presentation/widgets/banner_movie/banner_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  HomeRepository homeRepository;

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

    late MovieModel? bannerMovie;

    try {
      bannerMovie = await homeRepository.getBannerMovie(event.movieId);

      emit(BannerStateSuccess(movie: bannerMovie!));
    } on DioException catch (e) {
      final message = e.message ?? "Erro ao carregar o banner";
      emit(BannerStateError(message: message));
    }
  }
}
