import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/get_it_config.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/movie_details/movie_details_page.dart';
import 'package:filme_flix/repositories/home_repository.dart';
import 'package:filme_flix/services/toastr_service.dart';
import 'package:filme_flix/utils/image_imdb.dart';
import 'package:filme_flix/widgets/banner_movie/banner_movie_bloc.dart';
import 'package:filme_flix/widgets/banner_movie/banner_movie_event.dart';
import 'package:filme_flix/widgets/banner_movie/banner_movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class BannerMovie extends StatefulWidget {
  const BannerMovie({
    super.key,
  });

  @override
  State<BannerMovie> createState() => _BannerMovieState();
}

class _BannerMovieState extends State<BannerMovie> {
  late BannerBloc bannerBloc;
  late HomeRepository homeRepository;
  final String madameWebId = "634492";
  late final StreamSubscription _subscription;

  @override
  void initState() {
    homeRepository = getIt<HomeRepository>();
    bannerBloc = BannerBloc(homeRepository: homeRepository);
    bannerBloc.add(GetSetStateBanner(movieId: madameWebId));

    _subscription = bannerBloc.stream.listen((state) {
      if (!mounted) return;

      if (state is BannerStateError) {
        ToastrService.showError(context, state.message);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    bannerBloc.close();
    super.dispose();
  }

  void pushToMovieDetails(Movie movie) {
    context.push(MovieDetailsPage.route, extra: {"movie": movie});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<BannerBloc, BannerState>(
      bloc: bannerBloc,
      builder: (context, state) => switch (state) {
        BannerStateInitial() => const SizedBox.shrink(),
        BannerStateLoading() => const BannerLoader(),
        BannerStateSuccess() => InkWell(
            onTap: () => pushToMovieDetails(state.movie),
            child: CachedNetworkImage(
              imageUrl: ImageTmdb.getImageUrl(state.movie.posterPath),
              fit: BoxFit.cover,
              height: 500,
              width: size.width,
            ),
          ),
        BannerStateError() => const SizedBox(
            height: 500,
          )
      },
    );
  }
}

class BannerLoader extends StatelessWidget {
  const BannerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
    );
  }
}
