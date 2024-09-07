import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const HomeScreen._();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Screen',
              style:
                  context.textTheme.headlineLarge?.copyWith(color: Colors.red),
            ),
            Assets.png.allLegal.image(),
            const AlIcon(
              icon: AllLegal.menu,
            )
          ],
        ),
      ),
    );
  }
}
