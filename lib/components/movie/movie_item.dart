import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 24),
      child: InkWell(
          onTap: () {
            context.push(MovieDetailsPage.route, extra: {
              "movie": movie,
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(Movie.getImageUrl(movie.posterPath),
                  width: 60, height: 80, fit: BoxFit.cover),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: SizedBox(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            movie.releaseDate != null &&
                                    movie.releaseDate!.length >= 4
                                ? movie.releaseDate!.substring(0, 4)
                                : "Unknown",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )))
            ],
          )),
    );
  }
}
