import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textRegular = GoogleFonts.lexendDeca().copyWith(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

TextStyle textMedium = textRegular.copyWith(fontWeight: FontWeight.w500);
TextStyle textBold = textRegular.copyWith(fontWeight: FontWeight.w700);
TextStyle textLight = textRegular.copyWith(fontWeight: FontWeight.w100);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // Define other light theme properties here
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[100],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  // Define other dark theme properties here
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[900],
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  cardColor: Colors.grey[800],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);
