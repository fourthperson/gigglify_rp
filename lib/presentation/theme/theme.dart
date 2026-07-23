import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Helper function to create a theme-aware TextTheme
TextTheme _buildTextTheme(TextTheme base, Color defaultColor) {
  return base.copyWith(
    // Map old text styles to new TextTheme properties, adjusting font size and weight
    bodyLarge: GoogleFonts.lexendDeca(
      textStyle: base.bodyLarge?.copyWith(
        color: defaultColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
    // Corresponds to old textRegular
    bodyMedium: GoogleFonts.lexendDeca(
      textStyle: base.bodyMedium?.copyWith(
        color: defaultColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    // Corresponds to old textMedium, slightly larger
    titleLarge: GoogleFonts.lexendDeca(
      textStyle: base.titleLarge?.copyWith(
        color: defaultColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    // Corresponds to old textBold
    bodySmall: GoogleFonts.lexendDeca(
      textStyle: base.bodySmall?.copyWith(
        color: defaultColor,
        fontSize: 10,
        fontWeight: FontWeight.w100,
      ),
    ),
    // Corresponds to old textLight

    // You can also define other text styles if needed, ensuring they use GoogleFonts and defaultColor
    displayLarge: GoogleFonts.lexendDeca(
      textStyle: base.displayLarge?.copyWith(color: defaultColor),
    ),
    displayMedium: GoogleFonts.lexendDeca(
      textStyle: base.displayMedium?.copyWith(color: defaultColor),
    ),
    displaySmall: GoogleFonts.lexendDeca(
      textStyle: base.displaySmall?.copyWith(color: defaultColor),
    ),
    headlineLarge: GoogleFonts.lexendDeca(
      textStyle: base.headlineLarge?.copyWith(color: defaultColor),
    ),
    headlineMedium: GoogleFonts.lexendDeca(
      textStyle: base.headlineMedium?.copyWith(color: defaultColor),
    ),
    headlineSmall: GoogleFonts.lexendDeca(
      textStyle: base.headlineSmall?.copyWith(color: defaultColor),
    ),
    titleMedium: GoogleFonts.lexendDeca(
      textStyle: base.titleMedium?.copyWith(color: defaultColor),
    ),
    titleSmall: GoogleFonts.lexendDeca(
      textStyle: base.titleSmall?.copyWith(color: defaultColor),
    ),
    labelLarge: GoogleFonts.lexendDeca(
      textStyle: base.labelLarge?.copyWith(color: defaultColor),
    ),
    labelMedium: GoogleFonts.lexendDeca(
      textStyle: base.labelMedium?.copyWith(color: defaultColor),
    ),
    labelSmall: GoogleFonts.lexendDeca(
      textStyle: base.labelSmall?.copyWith(color: defaultColor),
    ),
  );
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[100],
  textTheme: _buildTextTheme(ThemeData.light().textTheme, Colors.black),
  colorScheme:
      ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ).copyWith(
        secondary: Colors.purple, // Accent color for light theme
        onSurface: Colors.black, // Default text color on surfaces
      ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ), // Default icon color for light theme
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[900],
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  cardColor: Colors.grey[800],
  textTheme: _buildTextTheme(ThemeData.dark().textTheme, Colors.white),
  colorScheme:
      ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ).copyWith(
        secondary: Colors.purpleAccent, // Accent color for dark theme
        onSurface: Colors.white, // Default text color on surfaces
      ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ), // Default icon color for dark theme
);
