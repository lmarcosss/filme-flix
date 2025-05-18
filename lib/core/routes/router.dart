import 'package:filme_flix/core/models/movie_model.dart';
import 'package:filme_flix/features/favorites/presentation/pages/favorites_page.dart';
import 'package:filme_flix/features/home/presentation/pages/home_page.dart';
import 'package:filme_flix/features/landing/presentation/pages/landing_page.dart';
import 'package:filme_flix/features/login/presentation/pages/login_page.dart';
import 'package:filme_flix/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:filme_flix/features/search/presentation/pages/search_page.dart';
import 'package:filme_flix/features/settings/presentation/pages/settings_page.dart';
import 'package:filme_flix/features/sign-up/presentation/pages/sign_up_page.dart';
import 'package:filme_flix/shared/presentation/widgets/nav_bar/logged_nav_bar_widget.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: LandingPage.route,
  routes: [
    GoRoute(
      path: LandingPage.route,
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      path: LoginPage.route,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: SignUpPage.route,
      builder: (context, state) => SignUpPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        int? index;
        final int homeIndex = 0;
        if (state.extra != null) {
          index = state.extra as int;
        }

        return LoggedNavBar(
          index: index ?? homeIndex,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: HomePage.route,
          pageBuilder: (_, __) => NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: SearchPage.route,
          pageBuilder: (_, __) => NoTransitionPage(
            child: SearchPage(),
          ),
        ),
        GoRoute(
          path: FavoritesPage.route,
          pageBuilder: (_, __) => NoTransitionPage(
            child: FavoritesPage(),
          ),
        ),
        GoRoute(
          path: SettingsPage.route,
          pageBuilder: (_, __) => NoTransitionPage(
            child: SettingsPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: MovieDetailsPage.route,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final movie = extra["movie"] as Movie;

        return MovieDetailsPage(movie: movie);
      },
    ),
  ],
);
