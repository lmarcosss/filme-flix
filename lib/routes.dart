import 'package:filme_flix/components/nav_bar/logged_nav_bar.dart';
import 'package:filme_flix/pages/favorites_page.dart';
import 'package:filme_flix/pages/home_page.dart';
import 'package:filme_flix/pages/landing_page.dart';
import 'package:filme_flix/pages/login_page.dart';
import 'package:filme_flix/pages/search_page.dart';
import 'package:filme_flix/pages/settings_page.dart';
import 'package:filme_flix/pages/sign_up_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => LandingPage(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/sign-up',
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
          path: '/home',
          pageBuilder: (_, __) => NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (_, __) => NoTransitionPage(
            child: SearchPage(),
          ),
        ),
        GoRoute(
          path: '/favorites',
          pageBuilder: (_, __) => NoTransitionPage(
            child: FavoritesPage(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (_, __) => NoTransitionPage(
            child: SettingsPage(),
          ),
        ),
      ])
]);
