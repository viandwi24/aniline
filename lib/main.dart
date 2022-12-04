import 'package:aniline/screens/splash/splash.dart';
import 'package:aniline/services/db.dart';
import 'package:aniline/utils/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      title: 'Aniline',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: DB.dbRead(),
        builder: (context, snapshot) {
          if (snapshot.data is bool && snapshot.data as bool == true) {
            return const SplashScreen();
          }

          return Scaffold(
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Lottie.asset('assets/anims/96031-loading-animation.json'),
                  const Text('Chottomatte kudasai...'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
