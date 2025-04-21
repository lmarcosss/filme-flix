import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/components/movie/movie_item.dart';
import 'package:filme_flix/pages/home_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
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

              return MovieItem(
                title: movie.title,
                imageUrl: movie.imageUrl,
                releaseYear: movie.releaseYear,
              );
            }));
  }
}
