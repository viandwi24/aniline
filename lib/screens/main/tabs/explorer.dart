import 'package:flutter/material.dart';

class ExplorerTabScreen extends StatefulWidget {
  const ExplorerTabScreen({Key? key}) : super(key: key);

  @override
  State<ExplorerTabScreen> createState() => _ExplorerTabScreenState();
}

class _ExplorerTabScreenState extends State<ExplorerTabScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Explorer");
  }
}
