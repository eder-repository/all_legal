import 'package:all_legal_ui/src/theme/palette.dart';
import 'package:all_legal_ui/src/typography/typography.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final class AlTheme {
  const AlTheme._();

  static const FlexSchemeData _gcFlexSchemeData = FlexSchemeData(
    name: 'All Legal Theme',
    description: 'All Legal Theme, custom definition of all colors',
    light: FlexSchemeColor(primary: _darkGrayishBlue, secondary: _white),
    dark: FlexSchemeColor(primary: _darkGrayishBlue, secondary: _white),
  );

  static const _darkGrayishBlue = Palette.darkGrayishBlue;
  static const _white = Palette.white;
  static const _lightGrayishCyan = Palette.lightGrayishCyan;
  static const _darkCyan = Palette.darkCyan;
  static const _smokeGray = Palette.smokeGray;
  static const _lightGrayBlue = Palette.lightGrayishBlue;
  static const _black = Palette.black;

  static const _moderateBlue = Palette.moderateBlue;

  static const _mostlyDesaturatedDarkBlue = Palette.mostlyDesaturatedDarkBlue;

  static const _lightGrayish = Palette.lightGrayish;

  static const _veryDarkGrayishBlue = Palette.veryDarkGrayishBlue;

  static const _verySoftBlue = Palette.verySoftBlue;

  static final light = FlexThemeData.light(
    colors: _gcFlexSchemeData.light,
  ).copyWith(
    scaffoldBackgroundColor: _lightGrayishCyan,
    dividerColor: _lightGrayBlue,
    primaryColor: _verySoftBlue,
    secondaryHeaderColor: _veryDarkGrayishBlue,
    colorScheme: const ColorScheme.light(
        onPrimary: _black,
        primary: _darkGrayishBlue,
        secondary: _darkCyan,
        tertiary: _smokeGray,
        onSecondary: _white,
        onSurface: _moderateBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightGrayishCyan,
      elevation: 0,
      iconTheme: _iconTheme,
      titleSpacing: 0,
      centerTitle: false,
    ),
    textTheme: TextStyles.light,
    hintColor: _smokeGray,
    iconTheme: _iconTheme,
    highlightColor: _mostlyDesaturatedDarkBlue,
  );

  static const _iconTheme = IconThemeData(color: Palette.midnightGray);

  ///[dark] is no implement in figma
  static final dark = FlexThemeData.dark(colors: _gcFlexSchemeData.dark);
}
