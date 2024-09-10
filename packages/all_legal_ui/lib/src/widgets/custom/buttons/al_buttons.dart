import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';

class AlBaseButton extends StatelessWidget {
  const AlBaseButton({
    required this.child,
    required this.color,
    required this.onPressed,
    super.key,
    this.borderRadius = borderRadius16,
    this.side = BorderSide.none,
    this.overlayColor,
    this.circularShape = false,
    this.maximumSize = 40,
    this.minimumSize = 40,
    this.withoutAnySize = false,
  });
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final BorderSide side;
  final Color? overlayColor;
  final bool circularShape;
  final double maximumSize;
  final double minimumSize;
  final bool withoutAnySize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: circularShape ? BorderRadius.zero : borderRadius,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          overlayColor: overlayColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          maximumSize: withoutAnySize
              ? const Size(double.infinity, 60)
              : Size.fromHeight(maximumSize),
          minimumSize: withoutAnySize
              ? const Size(double.infinity, 60)
              : Size.fromHeight(minimumSize),
          shape: circularShape
              ? CircleBorder(
                  side: side,
                )
              : RoundedRectangleBorder(
                  side: side,
                  borderRadius: borderRadius,
                ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class AlPrimaryButton extends StatelessWidget {
  const AlPrimaryButton({
    required this.text,
    super.key,
    this.borderRadius = borderRadius4,
    this.onPressed,
  });

  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlBaseButton(
      withoutAnySize: true,
      borderRadius: borderRadius,
      color: context.colorScheme.onSurface,
      onPressed: onPressed ?? () {},
      child: Text(text,
          style: context.primaryButtons
              ?.copyWith(color: context.colorScheme.onSecondary)),
    );
  }
}

class AlExtraButton extends StatelessWidget {
  const AlExtraButton({
    required this.text,
    this.icon,
    super.key,
    this.borderRadius = borderRadius4,
    this.onPressed,
    this.color,
    this.expand = false,
    this.textColor,
    this.textButtonStyle,
    this.borderColor,
  });
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final Color? color;
  final Color? textColor;

  final bool expand;
  final TextStyle? textButtonStyle;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return AlBaseButton(
      withoutAnySize: true,
      borderRadius: borderRadius,
      color: color ?? Colors.transparent,
      onPressed: onPressed ?? () {},
      side: borderColor != null
          ? BorderSide(
              color: borderColor!,
              width: 2,
            )
          : BorderSide.none,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            space8,
          ],
          Text(
            text,
            style: textButtonStyle ??
                context.primaryButtons?.copyWith(
                  color: textColor ?? context.theme.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}

class GFRoundButtons extends StatelessWidget {
  const GFRoundButtons({
    required this.icon,
    super.key,
    this.onPressed,
    this.height = 56,
    this.width = 56,
    this.boderColor,
  });

  final VoidCallback? onPressed;

  final Widget icon;
  final double height;
  final double width;
  final Color? boderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: AlBaseButton(
        color: Colors.transparent,
        side: BorderSide(
          color: boderColor ?? context.theme.scaffoldBackgroundColor,
        ),
        onPressed: onPressed ?? () {},
        circularShape: true,
        child: icon,
      ),
    );
  }
}
