import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    super.key,
    this.suffixIcon,
    required this.prefixIcon,
    required this.title,
    required this.description,
    this.onTap,
  });

  final Widget? suffixIcon;

  final Widget prefixIcon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final theme = context.theme;
    return AlCard(
      onPressed: onTap,
      shadow: false,
      padding: edgeInsets12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon,
          space20,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                      gap20,
                      Text(
                        description,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: AppFontWeight.light,
                        ),
                      ),
                    ],
                  ),
                ),
                if (suffixIcon != null)
                  suffixIcon!
                else
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.tertiary.withOpacity(.5),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
