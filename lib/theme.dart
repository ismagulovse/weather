import 'package:flutter/material.dart';

const blue = Color(0xFF477CF8);
const background = Color(0xFFE4EDF4);
const ink = Color(0xFF25364A);
const muted = Color(0xFF65768A);

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: background,
  colorScheme: ColorScheme.fromSeed(seedColor: blue),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: ink, fontSize: 16),
    bodyLarge: TextStyle(color: ink, fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: muted),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(color: blue, width: 2),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: blue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
  ),
);
