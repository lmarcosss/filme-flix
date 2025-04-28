import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          children: [],
        ));
  }
}
