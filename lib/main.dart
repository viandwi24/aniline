import 'package:aniline/screens/splash/splash.dart';
import 'package:aniline/utils/theme_builder.dart';
import 'package:flutter/material.dart';

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
    final anilineTheme = anilineThemeDataBuilder(context, null);

    return MaterialApp(
      theme: anilineTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
