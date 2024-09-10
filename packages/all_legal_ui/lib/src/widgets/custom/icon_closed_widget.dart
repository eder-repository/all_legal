import 'package:flutter/material.dart';

class IconClosedWdiget extends StatelessWidget {
  const IconClosedWdiget({
    super.key,
    required this.onTap,
    this.dimension = 24,
    required this.color,
  });
  final VoidCallback onTap;
  final double dimension;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.close,
          size: dimension,
        ));
  }
}
