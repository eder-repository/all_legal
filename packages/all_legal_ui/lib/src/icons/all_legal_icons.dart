// ignore_for_file: constant_identifier_names

import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/widgets.dart';

class AllLegalIcons {
  AllLegalIcons._();

  static const _kFontFam = FontFamily.allLegal;
  static const String _kFontPkg = AllLegalUI.package;
  static const IconData menu = IconData(
    0xe800,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
  static const IconData doc = IconData(
    0xe801,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
  static const IconData doc_add = IconData(
    0xe802,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
  static const IconData phonelink_lock = IconData(
    0xe803,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
  static const IconData vpn_lock = IconData(
    0xe804,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
}
