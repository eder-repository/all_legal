import 'package:all_legal_ui/src/constants/package.dart';
import 'package:flutter/widgets.dart';

class AllLegal {
  AllLegal._();

  static const _kFontFam = 'AllLegal';
  static const String? _kFontPkg = AllLegalUI.package;

  static const IconData menu =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
