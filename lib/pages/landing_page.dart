import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/components/buttons/primary_button.dart';
import 'package:filme_flix/components/buttons/secondary_button.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/login_page.dart';
import 'package:filme_flix/pages/sign_up_page.dart';
import 'package:filme_flix/repositories/movie_repository.dart';
import 'package:filme_flix/utils/image_imdb.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class LandingPage extends StatefulWidget {
  static const String route = "/";

  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Movie? bannerMovie;
  late bool isBannerMovieLoading;
  late MovieRepository movieRepository;

  @override
  void initState() {
    movieRepository = MovieRepository();

    getBannerMovie();

    super.initState();
  }

  Future<void> getBannerMovie() async {
    const String starWarsId = "181808";

    setState(() {
      isBannerMovieLoading = true;
    });

    final moviesApi = await movieRepository.getMovieDetails(starWarsId);

    if (moviesApi != null) {
      setState(() {
        bannerMovie = moviesApi;
        isBannerMovieLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
        child: Stack(alignment: Alignment.bottomCenter, children: [
      Positioned.fill(
        child: CachedNetworkImage(
          imageUrl: bannerMovie?.posterPath != null
              ? ImageTmdb.getImageUrl(bannerMovie!.posterPath,
                  size: ImageTmdb.w780)
              : "",
          fit: BoxFit.cover,
          placeholder: (context, url) {
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
          },
          errorWidget: (context, url, error) {
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
          },
        ),
      ),
      Container(
        height: size.height * 0.36,
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 19),
        decoration: BoxDecoration(
          color: Color(0xE6000000),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Watch movies anytime anywhere",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const Text(
                "Explore a vast collection of blockbuster movies, timeless classics, and the latest releases.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                )),
            PrimaryButton(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 16,
              ),
              onPressed: () {
                context.go(LoginPage.route);
              },
              text: "Login",
            ),
            SecondaryButton(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 16,
              ),
              onPressed: () {
                context.go(SignUpPage.route);
              },
              text: "Sign Up",
            )
          ],
        ),
      )
    ]));
  }
}
