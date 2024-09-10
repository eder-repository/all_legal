import 'package:all_legal_ui/src/extensions/build_context.dart';
import 'package:flutter/material.dart';

import 'icon_closed_widget.dart';

class TitleBottomSheet extends StatelessWidget {
  const TitleBottomSheet({
    required this.title,
    this.leadingChildTitle,
    this.onTap,
    required this.showClose,
    this.forceDarkMode = false,
    super.key,
    this.onClose,
    this.titleColor,
    this.closeIconColor,
    this.alignment,
  });

  final Widget title;
  final Widget? leadingChildTitle;
  final bool showClose;
  final VoidCallback? onTap;
  final bool forceDarkMode;
  final Color? titleColor;
  final Color? closeIconColor;
  final VoidCallback? onClose;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final color = titleColor ??
        (forceDarkMode
            ? context.colorScheme.onSecondary
            : context.colorScheme.tertiary);

    const sizeShield = 30.0;
    const spacerShieldText = 8.0;
    const spaceClose = 24.0;

    final text = DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      style: context.textTheme.displayLarge?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
        height: 0,
        fontSize: 22,
      ),
      child: title,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showClose && alignment != Alignment.centerLeft)
            Container(
              color: Colors.transparent,
              width: spaceClose,
              height: spaceClose,
            ),
          Expanded(
            child: Align(
              alignment: alignment ?? Alignment.center,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: leadingChildTitle != null
                          ? sizeShield + spacerShieldText
                          : 0,
                    ),
                    child: GestureDetector(
                      onTap: onTap,
                      child: text,
                    ),
                  ),
                  if (leadingChildTitle != null)
                    Positioned(
                      child: SizedBox.square(
                        dimension: sizeShield,
                        child: leadingChildTitle,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (showClose)
            IconClosedWdiget(
              onTap: () {
                if (onClose != null) {
                  onClose!.call();
                }
                context.canPop();
              },
              color: closeIconColor ?? context.colorScheme.tertiary,
            ),
        ],
      ),
    );
  }
}
