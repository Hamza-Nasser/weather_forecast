/// Defines all named route paths in the application.
///
/// Centralizes route path strings to avoid magic strings throughout the codebase.
/// Each route has a [name] for named navigation and a [path] for the URL pattern.
enum AppRoute {
  home(name: 'home', path: '/'),
  settings(name: 'settings', path: '/settings');

  const AppRoute({required this.name, required this.path});

  final String name;
  final String path;

  static AppRoute? fromPath(String path) {
    for (final route in AppRoute.values) {
      if (route.path == path) return route;
    }
    return null;
  }
}
