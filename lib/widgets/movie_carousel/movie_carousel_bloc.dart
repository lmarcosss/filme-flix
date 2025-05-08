import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_event.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  HomeRepository homeRepository = HomeRepository();
  final MovieCarouselTypeEnum movieType;
  MovieCarouselBloc({
    required this.movieType,
  }) : super(MovieCarouselStateInitial()) {
    on<GetSetStateMovieCarousel>(_loadSetStateMovieCarouselMovie);
  }

  Future<List<Movie>> _fetchMovies() async {
    switch (movieType) {
      case MovieCarouselTypeEnum.nowPlaying:
        return await homeRepository.getNowPlayingMovies();
      case MovieCarouselTypeEnum.popular:
        return await homeRepository.getPopularMovies();
      case MovieCarouselTypeEnum.topRated:
        return await homeRepository.getTopRatedMovies();
      case MovieCarouselTypeEnum.upcoming:
        return await homeRepository.getUpcomingMovies();
    }
  }

  Future<void> _loadSetStateMovieCarouselMovie(
    GetSetStateMovieCarousel event,
    Emitter<MovieCarouselState> emit,
  ) async {
    emit(MovieCarouselStateLoading());

    final movies = await _fetchMovies();

    emit(MovieCarouselStateSuccess(movies: movies));
  }
}
