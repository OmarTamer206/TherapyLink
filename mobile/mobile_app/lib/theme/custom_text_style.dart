import 'package:flutter/material.dart';
import 'package:mobile_app/theme/theme_helper.dart';

extension on TextStyle {
  TextStyle get scriptMTBold {
    return copyWith(
      fontFamily: 'Script MT Bold',
    );
  }
}

// A collection of pre-defined text styles for customizing text appearance,categorized by different font families and weights.
// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  //Body text style
  static TextStyle get bodyMediumBlack900 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get bodySmallOnErrorContainer =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );

  //Headline text style
  static TextStyle get headlineSmallBlack900 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
        fontWeight: FontWeight.w500,
      );
  static TextStyle get headlineSmallBlack900SemiBold =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get headlineSmallBlack900_1 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get headlineSmallOnErrorContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );

  //Label text style
  static TextStyle get labelLargeBlack900 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.7),
      );
  static TextStyle get labelLargeBlack900_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
      );
  static TextStyle get labelLargeBlack900_2 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.8),
      );

  static TextStyle get labelLargeOnErrorContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get labelMediumBlack900 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
        fontWeight: FontWeight.w500,
      );
  static TextStyle get labelMediumBold => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static TextStyle get labelMediumOnPrimary =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w700,
      );

  //Title text style
  static TextStyle get titleLargeBlack900 =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get titleLargeBlack900Bold =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleLargeBlack900SemiBold =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleLargeBlack900_1 =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get titleLargeBlack900_2 =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get titleLargeOnErrorContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleLargePrimary =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleLargePrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static TextStyle get titleLargeScriptMTBoldPrimaryContainer =>
      theme.textTheme.titleLarge!.scriptMTBold.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleLargeSemiBold =>
      theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
      );
  static TextStyle get titleMedium18_1 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
      );
  static TextStyle get titleMediumBlack900 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
        fontSize: 18,
      );
  static TextStyle get titleMediumBlack90018 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.8),
        fontSize: 18,
      );
  static TextStyle get titleMediumBlack90018_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
        fontSize: 18,
      );
  static TextStyle get titleMediumBlack900_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
      );
  static TextStyle get titleMediumBlack900_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.8),
      );
  static TextStyle get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumOnErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 18,
      );
  static TextStyle get titleMediumPrimaryContainerBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumSemiBold_1 =>
      theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmall15 =>
      theme.textTheme.titleSmall!.copyWith(
        fontSize: 15,
      );
  static TextStyle get titleSmallBlack900 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.7),
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleSmallBlack900Medium =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleSmallOnErrorContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 15,
      );
}
