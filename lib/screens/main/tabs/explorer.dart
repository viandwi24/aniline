import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExplorerTabScreen extends StatefulWidget {
  const ExplorerTabScreen({Key? key}) : super(key: key);

  @override
  State<ExplorerTabScreen> createState() => _ExplorerTabScreenState();
}

class _ExplorerTabScreenState extends State<ExplorerTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Explorer"),
    );
  }
}
