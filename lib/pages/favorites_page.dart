import 'package:filme_flix/components/header/header.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  static const String route = "/favorites";
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(title: "Favorites"),
        body: ListView(
          children: [],
        ));
  }
}
