import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    super.key,
    this.suffixIcon,
    required this.prefixIcon,
    required this.title,
    required this.description,
  });

  final Widget? suffixIcon;

  final Widget prefixIcon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlCard(
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
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.colorScheme.tertiary,
                        ),
                      ),
                      gap20,
                      Text(
                        description,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: AppFontWeight.light,
                        ),
                      ),
                    ],
                  ),
                ),
                if (suffixIcon != null) suffixIcon!
              ],
            ),
          ),
        ],
      ),
    );
  }
}
