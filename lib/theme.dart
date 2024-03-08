import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(

);

ThemeData darkTheme = ThemeData.dark().copyWith(

);

ThemeData purpleTheme = ThemeData.light().copyWith(
  // primaryColor: Colors.deepPurple,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
);

ThemeData greenTheme = ThemeData.light().copyWith(
  // primaryColor: Colors.deepPurple,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
);

ThemeData redTheme = ThemeData.light().copyWith(
  // primaryColor: Colors.deepPurple,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
);