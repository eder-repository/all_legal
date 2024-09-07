import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:all_legal_ui/src/theme/palette.dart';
import 'package:all_legal_ui/src/typography/typography.dart';
import 'package:flutter/material.dart';

final class TextStyles {
  const TextStyles._();

  static const _geistTextStyleBase = TextStyle(
    fontFamily: FontFamily.geist,
    fontWeight: AppFontWeight.regular,
    package: AllLegalUI.package,
    color: Palette.white,
  );

  static final TextStyle _headlineLarge = _geistTextStyleBase.copyWith(
    fontSize: 48,
  );

  static final TextStyle _headlineMedium = _geistTextStyleBase.copyWith(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    color: Palette.midnightGray,
  );

  static final TextStyle _headlineSmall = _geistTextStyleBase.copyWith(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    color: Palette.accent,
  );

  static final TextStyle _titleLarge = _geistTextStyleBase.copyWith(
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
  );

  static final TextStyle _bodyLarge = _titleLarge.copyWith(
    fontWeight: AppFontWeight.regular,
    color: Palette.white.withOpacity(.6),
  );

  static final TextStyle _titleMedium = _titleLarge.copyWith(
    fontWeight: AppFontWeight.bold,
    color: Palette.midnightGray,
  );

  static final TextStyle _titleSmall = _geistTextStyleBase.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: Palette.smokeGray,
  );

  static final TextStyle _bodyMedium = _titleSmall.copyWith(
    color: Palette.midnightGray,
  );

  //

  /// [TextTheme] for theme light
  static final light = TextTheme(
    headlineLarge: _headlineLarge,
    headlineMedium: _headlineMedium,
    headlineSmall: _headlineSmall,
    titleLarge: _titleLarge,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
  );
}
