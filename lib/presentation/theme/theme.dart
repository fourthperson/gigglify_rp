import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF15022D);
const Color secondaryColor = Color(0xFFFEC200);
const Color secondaryDarkColor = Color(0xFFC78A00);
const Color whiteColor = Color(0xFFF8F6FA);

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  final Color? secondaryDark;

  const BrandColors({required this.secondaryDark});

  @override
  BrandColors copyWith({Color? secondaryDark}) {
    return BrandColors(secondaryDark: secondaryDark ?? this.secondaryDark);
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      secondaryDark: Color.lerp(secondaryDark, other.secondaryDark, t),
    );
  }
}

TextTheme _buildTextTheme(TextTheme baseTextTheme, Color defaultColor) {
  final TextTheme lexendBase = GoogleFonts.lexendDecaTextTheme(baseTextTheme);

  return lexendBase
      .copyWith(
        bodyLarge: lexendBase.bodyLarge?.copyWith(
          color: defaultColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: lexendBase.bodyMedium?.copyWith(
          color: defaultColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: lexendBase.titleLarge?.copyWith(
          color: defaultColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        bodySmall: lexendBase.bodySmall?.copyWith(
          color: defaultColor,
          fontSize: 10,
          fontWeight: FontWeight.w100,
        ),
      )
      .apply(bodyColor: defaultColor, displayColor: defaultColor);
}

ThemeData get lightTheme {
  final lightScheme = ColorScheme.light(
    primary: primaryColor,
    onPrimary: whiteColor,
    secondary: secondaryColor,
    onSecondary: primaryColor,
    surface: whiteColor,
    onSurface: primaryColor,
    error: Colors.redAccent,
    onError: whiteColor,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: lightScheme,
    scaffoldBackgroundColor: lightScheme.surface,

    // Default Text: Primary Purple for Light Mode
    textTheme: _buildTextTheme(ThemeData.light().textTheme, primaryColor),

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: primaryColor,
    ),

    extensions: const [BrandColors(secondaryDark: secondaryDarkColor)],
  );
}

ThemeData get darkTheme {
  final darkScheme = ColorScheme.dark(
    primary: secondaryColor,
    onPrimary: primaryColor,
    secondary: secondaryColor,
    onSecondary: primaryColor,
    surface: primaryColor,
    onSurface: whiteColor,
    // error: const Color(0xFFCF6679),
    // onError: Colors.black,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkScheme,
    scaffoldBackgroundColor: const Color(0xFF0D011D),

    // Default Text: White for Dark Mode
    textTheme: _buildTextTheme(ThemeData.dark().textTheme, Colors.white),

    iconTheme: const IconThemeData(color: secondaryColor),

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: primaryColor,
    ),

    extensions: const [BrandColors(secondaryDark: secondaryDarkColor)],
  );
}
