import 'package:animenginamo/config/theme/theme_size.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'color_schemes.g.dart';

class CustomDarkTheme {
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: darkColorScheme.background.blend(darkColorScheme.surfaceTint, 5),
      buttonTheme: const ButtonThemeData(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding24),
        height: Sizes.buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.radius20),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: darkColorScheme.surfaceVariant,
        ),
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius20),
        ),
      ),
      dividerColor: darkColorScheme.outlineVariant,
      dialogTheme: const DialogTheme(
        elevation: 3,
        // backgroundColor: _darkCustomColorScheme.surfaceContainerHigh,
      ),
      //   appBarTheme: AppBarTheme(
      //     color: _darkCustomColorScheme.surfaceContainerLow,
      //   ),
      scrollbarTheme: ScrollbarThemeData(
        thickness: const MaterialStatePropertyAll(4),
        thumbVisibility: const MaterialStatePropertyAll(true),
        trackColor: MaterialStatePropertyAll(darkColorScheme.primary),
        thumbColor: MaterialStatePropertyAll(darkColorScheme.primary),
        trackBorderColor: MaterialStatePropertyAll(darkColorScheme.primary),
      ),
      visualDensity: VisualDensity.standard,
      inputDecorationTheme: const InputDecorationTheme(
        // fillColor: _darkCustomColorScheme.surfaceContainerHighest,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: Sizes.padding12),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.secondaryContainer,
        foregroundColor: darkColorScheme.onSecondaryContainer,
      ),
      textTheme: _textTheme(
        bodyColor: lightColorScheme.surface,
        surfaceTint: darkColorScheme.surfaceTint,
      ),
      primaryTextTheme: _textTheme(
        bodyColor: darkColorScheme.surface,
        surfaceTint: lightColorScheme.surfaceTint,
      ),
      fontFamily: GoogleFonts.roboto().fontFamily,
    );
  }

  static TextTheme _textTheme({required Color bodyColor, required Color surfaceTint}) => TextTheme(
        displayLarge: const TextStyle(fontSize: 57),
        displayMedium: const TextStyle(fontSize: 45),
        displaySmall: const TextStyle(fontSize: 36),
        headlineLarge: const TextStyle(fontSize: 32),
        headlineMedium: TextStyle(fontSize: 28, color: bodyColor.blend(surfaceTint, 30)),
        headlineSmall: const TextStyle(fontSize: 24),
        titleLarge: const TextStyle(fontSize: 22),
        titleMedium: const TextStyle(fontSize: 16),
        titleSmall: const TextStyle(fontSize: 14),
        bodyLarge: const TextStyle(fontSize: 16),
        bodyMedium: const TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12, color: bodyColor.blend(surfaceTint, 30)),
        labelLarge: const TextStyle(fontSize: 14),
        labelMedium: const TextStyle(fontSize: 12),
        labelSmall: const TextStyle(fontSize: 11),
      ).apply(
        bodyColor: bodyColor.blend(surfaceTint, 30),
      );
}
