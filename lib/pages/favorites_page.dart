import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/components/movie/movie_item.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/home_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  static const String route = "/favorites";
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(title: "Favorites"),
        body: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (
              context,
              index,
            ) {
              Movie movie = movies[index];

              return MovieItem(movie: movie);
            }));
  }
}
