// create function
import 'package:aniline/constant.dart';
import 'package:flutter/material.dart';

ThemeData anilineThemeDataBuilder(
  BuildContext context,
  TextTheme? customTextTheme,
) {
  // final textTheme = Theme.of(context).textTheme;

  customTextTheme ??= kDefaultTextTheme;

  final ThemeData kThemeData = ThemeData(
    textTheme: const TextTheme().merge(customTextTheme),
  );

  return kThemeData;
}
