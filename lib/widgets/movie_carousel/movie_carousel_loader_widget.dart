import 'package:filme_flix/widgets/movie_carousel/movie_carousel_item_widget.dart';
import 'package:flutter/material.dart';

class CarouselLoader extends StatelessWidget {
  final String title;

  const CarouselLoader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CarouselItemLoader(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
