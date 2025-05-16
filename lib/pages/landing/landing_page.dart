import 'package:cached_network_image/cached_network_image.dart';
import 'package:filme_flix/get_it_config.dart';
import 'package:filme_flix/models/movie_model.dart';
import 'package:filme_flix/pages/landing/landing_bloc.dart';
import 'package:filme_flix/pages/landing/landing_event.dart';
import 'package:filme_flix/pages/landing/landing_state.dart';
import 'package:filme_flix/pages/login/login_page.dart';
import 'package:filme_flix/pages/sign-up/sign_up_page.dart';
import 'package:filme_flix/repositories/landing_repository.dart';
import 'package:filme_flix/services/toastr_service.dart';
import 'package:filme_flix/utils/image_imdb.dart';
import 'package:filme_flix/widgets/buttons/primary_button_widget.dart';
import 'package:filme_flix/widgets/buttons/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late LandingBloc _landingBloc;
  late LandingRepository _landingRepository;
  final String _starWarsId = "181808";

  @override
  void initState() {
    _landingRepository = getIt<LandingRepository>();
    _landingBloc = LandingBloc(_landingRepository);
    _landingBloc.add(GetSetStateLanding(movieId: _starWarsId));

    super.initState();
  }

  @override
  void dispose() {
    _landingBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocListener<LandingBloc, LandingState>(
            bloc: _landingBloc,
            listener: (context, state) {
              if (state is LandingStateError) {
                ToastrService.showError(context, state.message);
              }
            },
            child: Stack(
              children: [
                BlocBuilder<LandingBloc, LandingState>(
                  bloc: _landingBloc,
                  builder: (context, state) {
                    return switch (state) {
                      LandingStateSuccess() => Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: state.bannerMovie.posterPath.isNotEmpty
                                ? ImageTmdb.getImageUrl(
                                    state.bannerMovie.posterPath,
                                    size: ImageTmdb.w780)
                                : "",
                            fit: BoxFit.cover,
                            height: size.height,
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
                      _ => const SizedBox.expand(),
                    };
                  },
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height * 0.36,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 29, horizontal: 19),
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
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
