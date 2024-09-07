import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:all_legal_ui/src/extensions/extensions.dart';
import 'package:all_legal_ui/src/layouts/layouts.dart';
import 'package:all_legal_ui/src/typography/typography.dart';
import 'package:flutter/material.dart';

enum AlIconSize {
  small(12),
  medium(16),
  large(20),
  bigger(24);

  const AlIconSize(this.size);
  final double size;
}

class AlIcon extends StatelessWidget {
  const AlIcon({
    required this.icon,
    super.key,
    this.rawSize,
    this.size = AlIconSize.bigger,
    this.fontWeight = AppFontWeight.regular,
    this.alignment = Alignment.center,
    this.padding = edgeInsetsZero,
    this.color,
  });

  final IconData icon;
  final double? rawSize;
  final AlIconSize size;
  final FontWeight fontWeight;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: Text(
          String.fromCharCode(icon.codePoint),
          style: TextStyle(
            color: color ?? context.theme.iconTheme.color,
            inherit: false,
            fontSize: rawSize ?? size.size,
            fontWeight: fontWeight,
            fontFamily: FontFamily.allLegal,
            package: AllLegalUI.package,
          ),
        ),
      ),
    );
  }
}
