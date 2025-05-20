import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/core/injection/locator.dart';
import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/core/services/toastr/toastr_service.dart';
import 'package:filme_flix/core/utils/image_imdb.dart';
import 'package:filme_flix/features/home/domain/repositories/home_repository.dart';
import 'package:filme_flix/features/home/presentation/widgets/banner_movie/banner_movie_bloc.dart';
import 'package:filme_flix/features/home/presentation/widgets/banner_movie/banner_movie_event.dart';
import 'package:filme_flix/features/home/presentation/widgets/banner_movie/banner_movie_state.dart';
import 'package:filme_flix/features/movie_details/presentation/pages/movie_details_page.dart';
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
  late BannerBloc _bannerBloc;
  late HomeRepository _homeRepository;
  final String _madameWebId = "634492";
  late final StreamSubscription _subscriptionError;

  @override
  void initState() {
    _homeRepository = getIt<HomeRepository>();
    _bannerBloc = BannerBloc(homeRepository: _homeRepository);
    _bannerBloc.add(GetSetStateBanner(movieId: _madameWebId));

    _subscriptionError = _bannerBloc.stream.listen(onShowError);

    super.initState();
  }

  @override
  void dispose() {
    _subscriptionError.cancel();
    _bannerBloc.close();
    super.dispose();
  }

  void onShowError(state) {
    if (!mounted) return;

    if (state is BannerStateError) {
      ToastrService.showError(context, state.message);
    }
  }

  void pushToMovieDetails(MovieModel movie) {
    context.push(MovieDetailsPage.route, extra: {"movie": movie});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<BannerBloc, BannerState>(
      bloc: _bannerBloc,
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
