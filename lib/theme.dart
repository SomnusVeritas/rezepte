import 'package:flutter/material.dart';

final _baseTheme = ThemeData(
  fontFamily: "Ubuntu",
  useMaterial3: true,
);

final lightTheme = _baseTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  ),
);

final darkTheme = _baseTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.purple.shade100,
  brightness: Brightness.dark,
));
