import 'package:filme_flix/components/carousel/carousel.dart';
import 'package:filme_flix/pages/home/widgets/top_rated_carousel/top_rated_carousel_bloc.dart';
import 'package:filme_flix/pages/home/widgets/top_rated_carousel/top_rated_carousel_event.dart';
import 'package:filme_flix/pages/home/widgets/top_rated_carousel/top_rated_carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedCarousel extends StatefulWidget {
  const TopRatedCarousel({super.key});

  @override
  State<TopRatedCarousel> createState() => _TopRatedCarouselState();
}

class _TopRatedCarouselState extends State<TopRatedCarousel> {
  late TopRatedCarouselBloc topRatedCarouselBloc;
  final String carouselTitle = "Top Rated Movies";

  @override
  void initState() {
    super.initState();

    topRatedCarouselBloc = TopRatedCarouselBloc();
    topRatedCarouselBloc.add(GetSetStateTopRatedCarousel());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCarouselBloc, TopRatedCarouselState>(
      bloc: topRatedCarouselBloc,
      builder: (context, state) => switch (state) {
        TopRatedCarouselStateInitial() => const SizedBox.shrink(),
        TopRatedCarouselStateLoading() => CarouselLoader(title: carouselTitle),
        TopRatedCarouselStateError() => Center(child: Text(state.message)),
        TopRatedCarouselStateSuccess() =>
          Carousel(title: carouselTitle, movies: state.topRatedMovies),
      },
    );
  }
}
