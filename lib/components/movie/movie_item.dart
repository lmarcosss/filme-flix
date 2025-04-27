import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? releaseDate;

  const MovieItem({
    super.key,
    required this.imageUrl,
    required this.title,
    this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, width: 60, height: 80, fit: BoxFit.cover),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                releaseDate != null && releaseDate!.length >= 4
                    ? releaseDate!.substring(0, 4)
                    : "Unknown",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
