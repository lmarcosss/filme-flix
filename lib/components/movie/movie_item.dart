import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/components/movie/movie_item_loader.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/movie_details.dart';
import 'package:filme_flix/utils/date_formatter.dart';
import 'package:filme_flix/utils/image_imdb.dart';
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
      padding: const EdgeInsets.only(
        bottom: 16,
        top: 16,
        left: 16,
        right: 24,
      ),
      child: InkWell(
          onTap: () {
            context.push(MovieDetailsPage.route, extra: {
              "movie": movie,
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: ImageImdb.getImageUrl(
                  movie.posterPath,
                  size: ImageImdb.w92,
                ),
                width: 60,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return MovieItemImageLoader();
                },
              ),
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
                            movie.releaseDate!.isNotEmpty
                                ? DateFormatter.getYearFromStringDate(
                                    movie.releaseDate!)
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
