import 'package:filme_flix/components/carousel/carousel_loader.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Carousel extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const Carousel({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return CarouselLoader();
    }

    return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 8,
          top: 16,
        ),
        child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                          width: 140,
                          height: 200,
                          child: InkWell(
                            onTap: () {
                              context.push(MovieDetailsPage.route, extra: {
                                "movie": movie,
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                Movie.getImageUrl(movie.posterPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    );
                  },
                ))
          ],
        ));
  }
}
