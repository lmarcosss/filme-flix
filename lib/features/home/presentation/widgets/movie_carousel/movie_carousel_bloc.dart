import 'package:dio/dio.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/home/domain/repositories/home_repository.dart';
import 'package:filme_flix/features/home/presentation/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_event.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  HomeRepository homeRepository;
  final MovieCarouselTypeEnum movieType;
  bool _isFetching = false;
  final String _commonErrorMessage = "Error loading movies. Please try again.";

  MovieCarouselBloc({
    required this.movieType,
    required this.homeRepository,
  }) : super(MovieCarouselStateInitial()) {
    on<GetSetStateMovieCarousel>(_loadSetStateMovieCarouselMovie);
  }

  Future<List<MovieModel>> _fetchMovies(int page) async {
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
      } on DioException catch (e) {
        emit(MovieCarouselStateError(
          message: e.message ?? _commonErrorMessage,
        ));
      } finally {
        _isFetching = false;
      }
    }

    emit(MovieCarouselStateLoading());

    try {
      final movies = await _fetchMovies(1);

      emit(MovieCarouselStateSuccess(movies: movies));
    } on DioException catch (e) {
      return emit(MovieCarouselStateError(
        message: e.message ?? _commonErrorMessage,
      ));
    } finally {
      _isFetching = false;
    }
  }
}
