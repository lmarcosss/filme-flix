import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/utils/image_imdb.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  const CarouselItem({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: ImageTmdb.getImageUrl(
          imageUrl,
          size: ImageTmdb.w154,
        ),
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
