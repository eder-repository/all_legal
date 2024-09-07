import 'package:flutter/material.dart';

extension SnackbarX on BuildContext {
  ScaffoldMessengerState get _scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(SnackBar snackBar) => _scaffoldMessenger
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

extension NavigatorX on BuildContext {
  bool canPop() => Navigator.canPop(this);
}

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  Brightness get brightness => theme.brightness;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension TextThemeX on BuildContext {
  TextTheme get textTheme => theme.textTheme;

  TextStyle? get primaryButtons => textTheme.titleLarge;

  TextStyle? get cardTitle => textTheme.titleMedium;
  TextStyle? get cardSubtitle => textTheme.titleSmall;
  TextStyle? get cardDate => textTheme.bodyMedium;
}

extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get gcSize => MediaQuery.sizeOf(this);
  double get height => gcSize.height;
  double get width => gcSize.width;
  EdgeInsets get padding => mediaQuery.padding;
}
