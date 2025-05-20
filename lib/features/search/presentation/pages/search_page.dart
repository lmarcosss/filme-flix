import 'dart:async';

import 'package:filme_flix/core/injection/locator.dart';
import 'package:filme_flix/core/widgets/header/header_widget.dart';
import 'package:filme_flix/core/widgets/inputs/search_input_widget.dart';
import 'package:filme_flix/core/widgets/movie_item/movie_item_loader_widget.dart';
import 'package:filme_flix/core/widgets/movie_item/movie_item_widget.dart';
import 'package:filme_flix/features/search/domain/repositories/search_repository.dart';
import 'package:filme_flix/features/search/presentation/bloc/search_bloc.dart';
import 'package:filme_flix/features/search/presentation/bloc/search_event.dart';
import 'package:filme_flix/features/search/presentation/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const String route = "/search";

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchRepository _searchRepository;
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  late SearchBloc _searchBloc;
  Timer? _debounce;

  @override
  void initState() {
    _searchRepository = getIt<SearchRepository>();
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    _searchBloc = SearchBloc(searchRepository: _searchRepository);

    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  void _onScroll() {
    final screenEndReached = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300;

    if (screenEndReached) {
      _searchBloc.add(GetSetStateSearch(
        query: _searchController.text,
        isLoadMore: true,
      ));
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchBloc.add(GetSetStateSearch(query: _searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Search"),
      body: Column(
        children: [
          BlocBuilder(
            bloc: _searchBloc,
            builder: (context, state) {
              return SearchInput(controller: _searchController);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder(
              bloc: _searchBloc,
              builder: (context, state) {
                return switch (state) {
                  SearchStateSuccess() => ListView.builder(
                      controller: _scrollController,
                      itemCount: state.searchResult.length,
                      itemBuilder: (context, index) {
                        final movie = state.searchResult[index];

                        if (movie.posterPath.isEmpty || movie.title.isEmpty) {
                          return SizedBox.shrink();
                        }

                        return MovieItem(movie: movie);
                      },
                    ),
                  SearchStateLoading() => ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const MovieItemLoader();
                      }),
                  SearchStateError() => Center(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  _ => SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
