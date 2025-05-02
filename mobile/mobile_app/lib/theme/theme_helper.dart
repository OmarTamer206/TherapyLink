import 'package:flutter/material.dart';


// Current theme storage
String _appTheme = "lightCode";

//Theme accessors
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

//Helper class for managing themes and colors

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  //changes the app theme to [_newTheme].
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  // Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  // Returns the current theme data.
  ThemeData _getThemeData() {
    final colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primaryContainer,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: colorScheme.primaryContainer,
      ),
    );
  }

  // Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  //Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.black900,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 24,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 10,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: appTheme.black900.withOpacity(0.6),
          fontSize: 8,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: appTheme.black900.withOpacity(0.6),
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );
}

// Class containing the supported color schemes.
class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF06303E),
    primaryContainer: Color(0XFF149FA8),
    errorContainer: Color(0XFF481416),
    onErrorContainer: Color(0XFFFFFFFF),
    onPrimary: Color(0XFFFED8E5),
  );
}

// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  //Black
  Color get black900 => const Color(0Xff000000);
  //BlueGray
  Color get blueGray100 => const Color(0XFFD9D9D9);
  //Gray
  Color get gray100 => const Color(0XFFFCF0F5);
  Color get gray200 => const Color(0XFFE8EAED);
  //Teal
  Color get teal50 => const Color(0XFFE1F1F6);
  Color get teal5001 => const Color(0XFFE1F0F5);
}
