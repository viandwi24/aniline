import 'package:flutter/material.dart';
import 'screens/main/main.dart';

void main() {
  runApp(const AnilineApp());
}

class AnilineApp extends StatelessWidget {
  const AnilineApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AnilineMainScreen(),
    );
  }
}
