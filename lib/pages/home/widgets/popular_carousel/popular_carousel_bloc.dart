import 'package:filme_flix/pages/home/widgets/popular_carousel/popular_carousel_event.dart';
import 'package:filme_flix/pages/home/widgets/popular_carousel/popular_carousel_state.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularCarouselBloc
    extends Bloc<PopularCarouselEvent, PopularCarouselState> {
  MovieRepository movieRepository = MovieRepository();
  PopularCarouselBloc() : super(PopularCarouselStateInitial()) {
    on<GetSetStatePopularCarousel>(_loadSetStatePopularCarouselMovie);
  }

  Future<void> _loadSetStatePopularCarouselMovie(
    GetSetStatePopularCarousel event,
    Emitter<PopularCarouselState> emit,
  ) async {
    emit(PopularCarouselStateLoading());

    final popularMovies = await movieRepository.getPopularMovies();

    emit(PopularCarouselStateSuccess(popularMovies: popularMovies));
  }
}
