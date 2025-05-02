import 'package:flutter/material.dart';
import 'package:mobile_app/theme/theme_helper.dart';

//A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  //Filled button style
  static ButtonStyle get fillErrorContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.errorContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillOnErrorContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onErrorContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  //Outline button style
  static ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get outlinePrimaryContainerTL6 => OutlinedButton.styleFrom(
        backgroundColor: appTheme.teal50,
        side: BorderSide(
          color: theme.colorScheme.primaryContainer,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.zero,
      );

  //text button style'
  static ButtonStyle get none => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      elevation: MaterialStateProperty.all<double>(0),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(color: Colors.transparent),
      ));
}
