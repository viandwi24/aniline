import 'package:flutter/material.dart';

class NewsTabScreen extends StatefulWidget {
  const NewsTabScreen({Key? key}) : super(key: key);

  @override
  State<NewsTabScreen> createState() => _NewsTabScreenState();
}

class _NewsTabScreenState extends State<NewsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("News");
  }
}
