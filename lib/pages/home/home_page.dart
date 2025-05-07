import 'package:filme_flix/enums/movie_carousel_type_enum.dart';
import 'package:filme_flix/widgets/banner_movie/banner_movie_widget.dart';
import 'package:filme_flix/widgets/movie_carousel/movie_carousel_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 0, bottom: 32),
      children: [
        BannerMovie(),
        MovieCarousel(movieType: MovieCarouselTypeEnum.nowPlaying),
        MovieCarousel(movieType: MovieCarouselTypeEnum.popular),
        MovieCarousel(movieType: MovieCarouselTypeEnum.topRated),
        MovieCarousel(movieType: MovieCarouselTypeEnum.upcoming),
      ],
    ));
  }
}
