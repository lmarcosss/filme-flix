import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselLoader extends StatelessWidget {
  const CarouselLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: 14, bottom: 16, top: 16),
          child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                  width: 132,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ))))),
      SizedBox(
        height: 200,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 130,
              height: 200,
              margin: const EdgeInsets.only(
                left: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
