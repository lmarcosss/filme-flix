import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/movie_details.dart';
import 'package:filme_flix/utils/image_imdb.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class BannerMovie extends StatelessWidget {
  final Movie? movie;
  final bool isLoading;

  const BannerMovie({
    super.key,
    required this.movie,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        if (movie != null) {
          context.push(MovieDetailsPage.route, extra: {
            "movie": movie,
          });
        }
      },
      child: CachedNetworkImage(
        imageUrl: movie?.posterPath != null
            ? ImageImdb.getImageUrl(
                movie!.posterPath,
                size: ImageImdb.w780,
              )
            : '',
        fit: BoxFit.cover,
        width: double.infinity,
        height: size.height * 0.6,
        placeholder: (context, url) => BannerLoader(),
        errorWidget: (context, url, error) => BannerLoader(),
      ),
    );
  }
}

class BannerLoader extends StatelessWidget {
  const BannerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
    );
  }
}
