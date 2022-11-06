import 'dart:math';

import 'package:aniline/components/button.dart';
import 'package:aniline/screens/main/main.dart';
import 'package:flutter/material.dart';
import 'package:aniline/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String signature = Random().nextInt(1000000000).toString();

  Future onPressMainButton() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AnilineMainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 30),
        decoration: const BoxDecoration(
          color: kBackgroundColor,
          image: DecorationImage(
            image: AssetImage('assets/images/sc.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "AniLine",
                style: TextStyle(
                  color: kTextLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "a portal app for discovery and explorer movie and anime in the world.",
                style: TextStyle(color: kTextLightColor),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AnilineButton(
                text: 'Getting Started $signature',
                onPressed: onPressMainButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
