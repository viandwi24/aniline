import 'package:aniline/main.dart';
import 'package:aniline/screens/main/main.dart';
import 'package:flutter/material.dart';
import 'package:aniline/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage('assets/images/sc.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "AniLine",
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo",
                style: TextStyle(color: kTextColor),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: ElevatedButton(
                  onPressed: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnilineMainApp()))),
                  child: Text("Getting Started")),
            )
          ],
        ),
      ),
    );
  }
}
