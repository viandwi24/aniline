import 'package:aniline/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main/main.dart';

void main() {
  runApp(const AnilineApp());
}

class AnilineApp extends StatefulWidget {
  const AnilineApp({super.key});

  @override
  State<AnilineApp> createState() => _AnilineAppState();
}

class _AnilineAppState extends State<AnilineApp> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.indieFlowerTextTheme(textTheme).copyWith(
        button: GoogleFonts.indieFlower(textStyle: TextStyle(fontSize: 20)),
        bodyText2: GoogleFonts.indieFlower(textStyle: TextStyle(fontSize: 18)),
      )),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
