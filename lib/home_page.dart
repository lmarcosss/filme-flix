import 'package:filme_flix/components/carousel/carousel.dart';
import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String imageUrl;
  final String releaseYear;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.releaseYear,
  });
}

final List<Movie> movies = [
  Movie(
    title: 'Inception',
    imageUrl: 'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
    releaseYear: '2010',
  ),
  Movie(
    title: 'Duna',
    imageUrl: 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
    releaseYear: '2021',
  ),
  Movie(
    title: 'Oppenheimer',
    imageUrl: 'https://image.tmdb.org/t/p/w500/ptpr0kGAckfQkJeJIt8st5dglvd.jpg',
    releaseYear: '2023',
  ),
  Movie(
    title: 'Batman',
    imageUrl: 'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
    releaseYear: '2022',
  ),
]; // TODO: Remove this list when integrating with the API

class HomePage extends StatelessWidget {
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
        Carousel(
          title: "Popular Movies",
          movies: movies,
        ),
      ],
    ));
  }
}
