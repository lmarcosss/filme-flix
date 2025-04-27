import 'package:filme_flix/components/carousel/carousel.dart';
import 'package:filme_flix/components/carousel/carousel_loader.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Inception',
    posterPath:
        'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
  ),
  Movie(
    id: 2,
    title: 'Dune',
    posterPath:
        'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
  ),
  Movie(
    id: 3,
    title: 'Openheimer',
    posterPath:
        'https://image.tmdb.org/t/p/w500/ptpr0kGAckfQkJeJIt8st5dglvd.jpg',
  ),
  Movie(
    id: 4,
    title: 'Batman',
    posterPath:
        'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
  ),
];

class HomePage extends StatelessWidget {
  static const String route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Image.asset(
          "assets/images/madame_web.png",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        FutureBuilder(
            future: MovieRepository().getMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CarouselLoader();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No movies found.'));
              } else {
                final movies = snapshot.data ?? [];

                return Carousel(
                  title: "Popular Movies",
                  movies: movies,
                );
              }
            }),
      ],
    ));
  }
}
