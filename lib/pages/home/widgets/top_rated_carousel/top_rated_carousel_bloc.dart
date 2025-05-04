import 'package:filme_flix/pages/home/widgets/top_rated_carousel/top_rated_carousel_event.dart';
import 'package:filme_flix/pages/home/widgets/top_rated_carousel/top_rated_carousel_state.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedCarouselBloc
    extends Bloc<TopRatedCarouselEvent, TopRatedCarouselState> {
  MovieRepository movieRepository = MovieRepository();
  TopRatedCarouselBloc() : super(TopRatedCarouselStateInitial()) {
    on<GetSetStateTopRatedCarousel>(_loadSetStateTopRatedCarouselMovie);
  }

  Future<void> _loadSetStateTopRatedCarouselMovie(
    GetSetStateTopRatedCarousel event,
    Emitter<TopRatedCarouselState> emit,
  ) async {
    emit(TopRatedCarouselStateLoading());

    final topRatedMovies = await movieRepository.getTopRatedMovies();

    if (topRatedMovies.isEmpty) {
      emit(TopRatedCarouselStateError(message: "Movies not founded"));
      return;
    }

    emit(TopRatedCarouselStateSuccess(topRatedMovies: topRatedMovies));
  }
}
