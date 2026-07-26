/// Responsive width breakpoints used by [LayoutBuilder] to switch between
/// mobile and tablet layouts.
class AppBreakpoints {
  const AppBreakpoints._();

  /// Below this width → mobile layout (single column).
  /// At or above → tablet layout (two columns).
  static const double tablet = 600;

  /// At or above → desktop / large-tablet layout (wider spacing).
  static const double desktop = 1024;
}
