import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final bool isLoading;
  const CarouselItem({
    super.key,
    required this.imageUrl,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: Movie.getImageUrl(imageUrl),
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return const CarouselItemLoader();
        },
      ),
    );
  }
}

class CarouselItemLoader extends StatelessWidget {
  const CarouselItemLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
