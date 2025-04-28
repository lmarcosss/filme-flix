import 'dart:async';

import 'package:filme_flix/components/header/header.dart';
import 'package:filme_flix/components/inputs/search_input.dart';
import 'package:filme_flix/components/movie/movie_item.dart';
import 'package:filme_flix/components/movie/movie_item_loader.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const String route = "/search";

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late MovieRepository movieRepository;
  late List<Movie> searchedMovies = [];
  late bool isLoading = false;

  Timer? _debounce;
  String result = '';

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    movieRepository = MovieRepository();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchApi(_searchController.text);
    });
  }

  Future<void> _searchApi(String query) async {
    if (query.isEmpty) {
      return setState(() {
        searchedMovies = [];
      });
    }

    setState(() {
      isLoading = true;
    });

    final newSearchedMovies = await movieRepository.searchMovies(query);

    setState(() {
      searchedMovies = newSearchedMovies;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Search"),
      body: Column(
        children: [
          SearchInput(controller: _searchController),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: searchedMovies.length,
              itemBuilder: (context, index) {
                final movie = searchedMovies[index];

                if (isLoading) {
                  return const MovieItemLoader();
                }

                if (!isLoading && movie.posterPath.isEmpty) {
                  return SizedBox.shrink();
                }

                return MovieItem(movie: movie);
              },
            ),
          ),
        ],
      ),
    );
  }
}
