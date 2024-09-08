import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';

class AlCard extends StatelessWidget {
  const AlCard({
    required this.child,
    this.shadow = true,
    super.key,
    this.border,
    this.color,
    this.borderRadius = borderRadius8,
    this.width,
    this.height,
    this.onPressed,
    this.padding,
    this.margin,
    this.onLongPress,
  });
  final Border? border;
  final Color? color;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return InkWell(
      borderRadius: borderRadius,
      onTap: onPressed,
      onLongPress: onLongPress,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color ?? colorScheme.onSecondary,
            border: border ??
                Border.all(color: colorScheme.secondary.withOpacity(.4)),
            borderRadius: borderRadius,
            boxShadow: shadow == true
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.1,
                      ),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Padding(padding: padding ?? edgeInsetsH16, child: child),
        ),
      ),
    );
  }
}
