import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_event.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  HomeRepository homeRepository;
  final MovieCarouselTypeEnum movieType;
  bool _isFetching = false;

  MovieCarouselBloc({
    required this.movieType,
    required this.homeRepository,
  }) : super(MovieCarouselStateInitial()) {
    on<GetSetStateMovieCarousel>(_loadSetStateMovieCarouselMovie);
  }

  Future<List<Movie>> _fetchMovies(int page) async {
    switch (movieType) {
      case MovieCarouselTypeEnum.nowPlaying:
        return await homeRepository.getNowPlayingMovies(page);
      case MovieCarouselTypeEnum.popular:
        return await homeRepository.getPopularMovies(page);
      case MovieCarouselTypeEnum.topRated:
        return await homeRepository.getTopRatedMovies(page);
      case MovieCarouselTypeEnum.upcoming:
        return await homeRepository.getUpcomingMovies(page);
    }
  }

  Future<void> _loadSetStateMovieCarouselMovie(
    GetSetStateMovieCarousel event,
    Emitter<MovieCarouselState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    final currentState = state;

    if (event.isLoadMore && currentState is MovieCarouselStateSuccess) {
      if (currentState.listIsFinished) {
        return;
      }

      try {
        final newResults = await _fetchMovies(currentState.currentPage + 1);

        if (newResults.isEmpty) {
          return emit(currentState.copyWith(listIsFinished: true));
        }

        return emit(currentState.copyWith(
          movies: [...currentState.movies, ...newResults],
          currentPage: currentState.currentPage + 1,
        ));
      } catch (e) {
        emit(MovieCarouselStateError(
          message: "Error loading movies. Please try again.",
        ));
      } finally {
        _isFetching = false;
      }
    }

    emit(MovieCarouselStateLoading());

    try {
      final movies = await _fetchMovies(1);

      emit(MovieCarouselStateSuccess(movies: movies));
    } catch (e) {
      return emit(MovieCarouselStateError(
        message: "Error loading movies. Please try again.",
      ));
    } finally {
      _isFetching = false;
    }
  }
}
