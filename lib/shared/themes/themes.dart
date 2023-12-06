import 'package:flutter/material.dart';

part 'color_schemes.g.dart';

final lightTheme = ThemeData(
  colorScheme: _lightColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: _lightColorScheme.inversePrimary,
    centerTitle: true,
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData(
    colorScheme: _darkColorScheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: _darkColorScheme.inversePrimary,
    ));
