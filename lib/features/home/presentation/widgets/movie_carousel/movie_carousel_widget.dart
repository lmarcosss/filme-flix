import 'dart:async';

import 'package:filme_flix/core/di/get_it_config.dart';
import 'package:filme_flix/core/services/toastr/toastr_service.dart';
import 'package:filme_flix/features/home/data/repositories/home_repository_impl.dart';
import 'package:filme_flix/features/home/presentation/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_bloc.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_event.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_item_widget.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_loader_widget.dart';
import 'package:filme_flix/features/home/presentation/widgets/movie_carousel/movie_carousel_state.dart';
import 'package:filme_flix/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieCarousel extends StatefulWidget {
  final MovieCarouselTypeEnum movieType;
  const MovieCarousel({
    super.key,
    required this.movieType,
  });

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late MovieCarouselBloc _movieCarouselBloc;
  late HomeRepositoryImpl _homeRepository;
  late ScrollController _scrollController;
  late StreamSubscription _subscriptionError;

  @override
  void initState() {
    super.initState();
    _homeRepository = getIt<HomeRepositoryImpl>();
    _scrollController = ScrollController();
    _movieCarouselBloc = MovieCarouselBloc(
      movieType: widget.movieType,
      homeRepository: _homeRepository,
    );
    _movieCarouselBloc.add(GetSetStateMovieCarousel());
    _scrollController.addListener(_onScroll);
    _subscriptionError = _movieCarouselBloc.stream.listen(onShowError);
  }

  @override
  void dispose() {
    _movieCarouselBloc.close();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _subscriptionError.cancel();
    super.dispose();
  }

  void onShowError(state) {
    if (!mounted) return;

    if (state is MovieCarouselStateError) {
      ToastrService.showError(context, state.message);
    }
  }

  void _onScroll() {
    final screenEndReached = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300;

    if (screenEndReached) {
      _movieCarouselBloc.add(GetSetStateMovieCarousel(
        isLoadMore: true,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.movieType.title;

    return BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
      bloc: _movieCarouselBloc,
      builder: (context, state) => switch (state) {
        MovieCarouselStateInitial() => const SizedBox.shrink(),
        MovieCarouselStateLoading() => CarouselLoader(title: title),
        MovieCarouselStateError() => const SizedBox.shrink(),
        MovieCarouselStateSuccess() => Padding(
            padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    )),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 140,
                          height: 200,
                          child: InkWell(
                            onTap: () {
                              context.push(
                                MovieDetailsPage.route,
                                extra: {
                                  "movie": movie,
                                },
                              );
                            },
                            child: CarouselItem(
                              imageUrl: movie.posterPath,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }
}
