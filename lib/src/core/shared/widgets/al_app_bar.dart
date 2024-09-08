import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';

class AlAppBar extends StatelessWidget implements PreferredSize {
  const AlAppBar({super.key, this.automaticallyImplyLeading = true});

  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Row(
        children: [
          const AlIcon(icon: AllLegalIcons.menu),
          space20,
          Assets.png.allLegal.image(height: 50),
        ],
      ),
      centerTitle: false,
      titleSpacing: 20,
      actions: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: context.theme.primaryColor, width: 3),
              shape: BoxShape.circle),
          child: const ALCachedImage(
            url:
                'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/e40b6ea6361a1abe28f32e7910f63b66/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
            height: 50,
            width: 50,
            fit: BoxFit.fitHeight,
            circular: true,
          ),
        ),
        space20,
      ],
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
