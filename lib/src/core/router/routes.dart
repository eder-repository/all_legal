class Routes {
  const Routes._({required this.name, required this.path});
  final String name;
  final String path;

  static Routes get splash => const Routes._(
        name: 'Splash',
        path: '/splash',
      );

  static Routes get home => const Routes._(
        name: 'Home',
        path: '/home',
      );

  // static String? redirect(String? fullPath) {
  //   if (fullPath == splash.path) {
  //     return home.path;
  //   }
  //   return null;
  // }
}
