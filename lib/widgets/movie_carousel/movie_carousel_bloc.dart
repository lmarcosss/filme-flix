import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_event.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  MovieRepository movieRepository = MovieRepository();
  final MovieCarouselTypeEnum movieType;
  MovieCarouselBloc({
    required this.movieType,
  }) : super(MovieCarouselStateInitial()) {
    on<GetSetStateMovieCarousel>(_loadSetStateMovieCarouselMovie);
  }

  Future<List<Movie>> _fetchMovies() async {
    switch (movieType) {
      case MovieCarouselTypeEnum.nowPlaying:
        return await movieRepository.getNowPlayingMovies();
      case MovieCarouselTypeEnum.popular:
        return await movieRepository.getPopularMovies();
      case MovieCarouselTypeEnum.topRated:
        return await movieRepository.getTopRatedMovies();
      case MovieCarouselTypeEnum.upcoming:
        return await movieRepository.getUpcomingMovies();
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
