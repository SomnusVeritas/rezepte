import 'package:flutter/material.dart';

final _baseTheme = ThemeData(
  fontFamily: "Ubuntu",
  useMaterial3: true,
).copyWith(
  dividerTheme: const DividerThemeData(indent: 0, endIndent: 0),
);

final lightTheme = _baseTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[600],
    ));

final darkTheme = _baseTheme.copyWith(
  colorScheme: _darkColorScheme,
  scaffoldBackgroundColor: _darkColorScheme.background,
);

final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.purple.shade100,
  brightness: Brightness.dark,
);
