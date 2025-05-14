import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/get_it_config.dart';
import 'package:filme_flix/pages/movie_details/movie_details_page.dart';
import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_bloc.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_event.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_item_widget.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_loader_widget.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_state.dart';
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
  late HomeRepository _homeRepository;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _homeRepository = getIt<HomeRepository>();
    _scrollController = ScrollController();
    _movieCarouselBloc = MovieCarouselBloc(
      movieType: widget.movieType,
      homeRepository: _homeRepository,
    );
    _movieCarouselBloc.add(GetSetStateMovieCarousel());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _movieCarouselBloc.close();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
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
        MovieCarouselStateError() => Center(child: Text(state.message)),
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
