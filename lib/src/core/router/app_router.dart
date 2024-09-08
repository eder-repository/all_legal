import 'package:all_legal/src/features/features.dart';
import 'package:all_legal/src/features/home/presentation/screens/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class AppRouter {
  const AppRouter._();

  static GoRouter router(
    BuildContext context,
  ) =>
      GoRouter(
        initialLocation: Routes.splash.path,
        debugLogDiagnostics: kDebugMode,
        routes: [
          GoRoute(
            path: Routes.splash.path,
            name: Routes.splash.name,
            builder: SplashScreen.builder,
          ),
          GoRoute(
            path: Routes.home.path,
            name: Routes.home.name,
            builder: HomeScreen.builder,
          ),
          GoRoute(
            path: Routes.signDocuemnt.path,
            name: Routes.signDocuemnt.name,
            builder: SignDocument.builder,
          ),
        ],
        // redirect: (context, state) => Routes.redirect(state.fullPath),
      );
}
