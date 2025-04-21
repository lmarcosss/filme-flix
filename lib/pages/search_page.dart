import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/components/inputs/search_input.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(title: "Search"),
        body: ListView(
          children: [
            SearchInput(),

            // TODO: Create list of movies here
          ],
        ));
  }
}
