import 'package:flutter/material.dart';
import 'package:mobile_app/theme/theme_helper.dart';

class AppDecoration {
  //Background decorations
  static BoxDecoration get background => BoxDecoration(
        color: appTheme.teal50,
      );

  //Buttons decorations
  static BoxDecoration get buttonsCTA => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  //Fill decorations
  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal5001,
      );

  //outline decorations
  static BoxDecoration get outlineBlack => const BoxDecoration();
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.teal50,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1,
        ),
      );
  static BoxDecoration get outlinePrimary1 => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1,
        ),
      );

  //Widgetorinput decorations
  static BoxDecoration get widgetorinput => BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
      );
}

class BorderRadiusStyle {
  //Circle borders
  static BorderRadius get circleBorder102 => BorderRadius.circular(
        102,
      );
  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40,
      );

  //Custom borders
  static BorderRadius get customBorderBL14 => const BorderRadius.only(
        topRight: Radius.circular(14),
        bottomLeft: Radius.circular(14),
        bottomRight: Radius.circular(14),
      );
  static BorderRadius get customBorderTL14 =>const BorderRadius.vertical(
        top: Radius.circular(14),
      );
  static BorderRadius get customBorderTL141 => const BorderRadius.only(
        topLeft: Radius.circular(14),
        bottomLeft: Radius.circular(14),
        bottomRight: Radius.circular(14),
      );

  //Rounded borders
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16,
      );
  static BorderRadius get roundedBorder26 => BorderRadius.circular(
        26,
      );
  static BorderRadius get roundedBorder6 => BorderRadius.circular(
        6,
      );
  static BorderRadius get roundedBorder74 => BorderRadius.circular(
        74,
      );
}
