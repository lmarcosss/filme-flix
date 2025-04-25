import 'package:filme_flix/routes/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoggedNavBar extends StatefulWidget {
  final Widget child;
  final int index;
  const LoggedNavBar({super.key, required this.child, required this.index});

  @override
  State<LoggedNavBar> createState() => _LoggedNavBarState();
}

class _LoggedNavBarState extends State<LoggedNavBar> {
  final tabs = [
    RoutesConstants.home,
    RoutesConstants.search,
    RoutesConstants.favorites,
    RoutesConstants.settings,
  ];

  void changePage(int index) {
    final route = tabs[index];

    if (context.mounted) {
      context.go(route, extra: index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        unselectedItemColor: Colors.white,
        selectedItemColor: colorScheme.primary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Searcn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
