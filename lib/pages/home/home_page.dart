import 'package:filme_flix/pages/home/widgets/banner/banner_widget.dart';
import 'package:filme_flix/pages/home/widgets/popular_carousel/popular_carousel_widget.dart';
import 'package:filme_flix/pages/home/widgets/top_rated_carousel/top_rated_carousel_widget.dart';
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
        PopularCarousel(),
        TopRatedCarousel(),
      ],
    ));
  }
}
