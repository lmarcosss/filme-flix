import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatelessWidget {
  static const String route = "/movie-details";

  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final movie = extra["movie"] as Movie;

    return Scaffold(
        appBar: Header(title: movie.title),
        body: ListView(
          children: [
            SizedBox(
              height: 220,
              child: CachedNetworkImage(
                imageUrl: Movie.getImageUrl(movie.backdropPath.isNotEmpty
                    ? movie.backdropPath
                    : movie.posterPath),
                placeholder: (context, url) {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade900,
                      highlightColor: Colors.grey.shade800,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      movie.releaseDate!.isNotEmpty
                          ? DateFormatter.getYearFromStringDate(
                              movie.releaseDate!)
                          : "Unknown",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(movie.overview,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                        )),
                  ],
                ))
          ],
        ));
  }
}
