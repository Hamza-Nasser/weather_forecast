---
name: Widget Architecture
description: Rules for Flutter widget construction: prohibition of helper build functions (Widget _buildX), strict usage of standalone class widgets (StatelessWidget/StatefulWidget), and modular file organization placing components into separate files under components/ directories.
---

# Widget Architecture

To ensure optimal performance, proper element tree rebuild scopes, and clean maintainable code, follow these strict rules when building Flutter UI in this project.

---

## 1. Zero Helper Widget Functions (`Widget _buildX`)

### ❌ Strictly Prohibited
Never create private or public helper methods inside a widget or screen class that return `Widget`, such as:

```dart
// BAD: Do NOT do this
Widget _buildHeader(BuildContext context, EditProfileState state) {
  return Container(...);
}

Widget _buildAvatarImage(EditProfileState state) {
  return Image.file(...);
}
```

#### Why `Widget _buildX` Functions Are Harmful:
- They cause Flutter to re-execute building of the entire method on every parent rebuild, bypassing Flutter's widget tree caching (`const` optimizations).
- They share context and internal state unnecessarily, leading to accidental context leaks and difficult-to-trace state bugs.
- They prevent separate widget lifecycle management (e.g., `initState`, `dispose`, custom keys, element tree reuse).

---

## 2. Always Use Standalone Class Widgets

### ✅ Required Pattern
Extract all sub-components, sections, and items into dedicated `StatelessWidget` (or `StatefulWidget` when local state/controllers are needed) class declarations with `const` constructors.

```dart
// GOOD: Always use class widgets
class _ProfileAvatarImage extends StatelessWidget {
  const _ProfileAvatarImage({required this.state});

  final EditProfileState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorPalette;
    return Container(...);
  }
}
```

---

## 3. Modular File Structure (`components/` Directory)

For screens and complex UI widgets, do **not** clutter a single screen file with all sub-component class declarations. Break each sub-component into its own separate file under a `components/` sub-directory.

### Example 1: Feature Screen Organization
Reference: `lib/features/settings/presentation/`

```
lib/features/settings/presentation/
├── screens/
│   └── settings_screen.dart
└── components/
    ├── language_selector.dart
    └── theme_selector.dart
```

### Example 2: Shared UI Component Breakdown
Reference: `lib/shared/ui/widgets/unit_card/`

```
lib/shared/ui/widgets/unit_card/
├── unit_card.dart
└── components/
    ├── ui_unit_card_image_section.dart
    ├── ui_unit_card_image_slider.dart
    ├── ui_unit_card_location_price_row.dart
    └── ui_unit_card_title_row.dart
```

---

## Summary Rules Checklist

1. **NO `Widget _build...()` methods anywhere.**
2. **YES to `class MyComponent extends StatelessWidget`.**
3. **Separate files in `components/` for non-trivial sub-widgets.**
4. **Use `const` constructors for all sub-components.**
