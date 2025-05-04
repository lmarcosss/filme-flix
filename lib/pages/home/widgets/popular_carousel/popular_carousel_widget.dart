import 'package:filme_flix/components/carousel/carousel.dart';
import 'package:filme_flix/pages/home/widgets/popular_carousel/popular_carousel_bloc.dart';
import 'package:filme_flix/pages/home/widgets/popular_carousel/popular_carousel_event.dart';
import 'package:filme_flix/pages/home/widgets/popular_carousel/popular_carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularCarousel extends StatefulWidget {
  const PopularCarousel({super.key});

  @override
  State<PopularCarousel> createState() => _PopularCarouselState();
}

class _PopularCarouselState extends State<PopularCarousel> {
  late PopularCarouselBloc popularCarouselBloc;
  final String carouselTitle = "Popular Movies";

  @override
  void initState() {
    super.initState();

    popularCarouselBloc = PopularCarouselBloc();
    popularCarouselBloc.add(GetSetStatePopularCarousel());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCarouselBloc, PopularCarouselState>(
      bloc: popularCarouselBloc,
      builder: (context, state) => switch (state) {
        PopularCarouselStateInitial() => const SizedBox.shrink(),
        PopularCarouselStateLoading() => CarouselLoader(title: carouselTitle),
        PopularCarouselStateError() => Center(child: Text(state.message)),
        PopularCarouselStateSuccess() =>
          Carousel(title: carouselTitle, movies: state.popularMovies),
      },
    );
  }
}
