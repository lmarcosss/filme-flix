import 'package:filme_flix/core/di/get_it_config.dart';
import 'package:filme_flix/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Filme Flix',
      theme: ThemeData(
          textTheme: GoogleFonts.getTextTheme("Inter").apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xff32A873),
            onPrimary: Color(0xff121212),
            secondary: Colors.transparent,
            onSecondary: Color(0xff32A873),
            error: Colors.red,
            onError: Colors.white,
            surface: Color(0xff121212),
            onSurface: Colors.white,
          )),
      routerConfig: router,
    );
  }
}
