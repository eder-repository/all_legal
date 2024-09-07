import 'package:flutter/material.dart';

class GFConditionalCenter extends StatelessWidget {
  const GFConditionalCenter({
    required this.child,
    this.centered = true,
    super.key,
  });

  final Widget child;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return centered ? Center(child: child) : child;
  }
}
