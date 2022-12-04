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
  int _selectedIndex = 0;
  final List<String> _listText = [
    'A portal app for discovery and explorer movie and anime in the world.',
    'Get anime, manga and anime recommendation every day.',
    'Explore anime with our search',
  ];
  final List<String> _listBg = [
    'assets/images/land_1.jpg',
    'assets/images/land_2.jpg',
    'assets/images/land_3.jpg',
  ];

  Future onPressMainButton() async {
    if (_selectedIndex < 2) {
      setState(() {
        _selectedIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AnilineMainScreen(),
        ),
      );
    }
  }

  onPressSkipButton() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/logo.png',
            width: 128,
            height: 128,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          image: DecorationImage(
            image: AssetImage(_listBg[_selectedIndex]),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                    child: Text(
                      _listText[_selectedIndex],
                      style: const TextStyle(color: kTextLightColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (_selectedIndex < 2)
                      Flexible(
                        child: Container(
                          child: AnilineButton(
                            color: Colors.transparent,
                            text: "Skip",
                            onPressed: onPressSkipButton,
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 10,
                            width: _selectedIndex == 0 ? 40 : 10,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 0
                                  ? kPrimaryColor
                                  : kPrimaryColor.withOpacity(0.4),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 10,
                            width: _selectedIndex == 1 ? 40 : 10,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 1
                                  ? kPrimaryColor
                                  : kPrimaryColor.withOpacity(0.4),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 10,
                            width: _selectedIndex == 2 ? 40 : 10,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 2
                                  ? kPrimaryColor
                                  : kPrimaryColor.withOpacity(0.4),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_selectedIndex < 2)
                      Flexible(
                        child: Container(
                          child: AnilineButton(
                            color: Colors.transparent,
                            text: "Next",
                            onPressed: onPressMainButton,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_selectedIndex >= 2)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  child: AnilineButton(
                    text: "Get Started",
                    onPressed: onPressMainButton,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
