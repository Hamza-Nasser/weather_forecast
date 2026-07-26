---
name: Localization
description: Localization workflow for adding translatable strings using easy_localization, TranslationKeys, en.json/ar.json translation files, RTL layout verification, and test helper updates.
---

# Localization

## Never Hardcode User-Facing Text

For each new or changed string, follow this checklist:

1. **Add matching semantic keys** to `assets/translations/en.json` and `ar.json`.
2. **Declare the key** in `TranslationKeys`.
3. **Render it** through easy_localization with `.tr()`.
4. **Update `test/test_helper.dart`** when a localized widget test relies on the new key.
5. **Verify** English and Arabic behavior, including direction-sensitive layout.

## Usage Pattern

```dart
// In TranslationKeys
static const String myFeatureTitle = 'my_feature.title';

// In en.json
{
  "my_feature": {
    "title": "My Feature"
  }
}

// In ar.json
{
  "my_feature": {
    "title": "ميزتي"
  }
}

// In widget code
UiText(TranslationKeys.myFeatureTitle.tr())
```

## What NOT to Put in Translation Files

- Backend error text
- Analytics event names
- Route paths
- Asset paths

## Assets

- Centralize new image paths in `ImageAssets` and SVG paths in `SvgAssets`.
- Render SVG assets through `UiSvg` so the `vector_graphics` transformer is used.
- Add new asset directories to `pubspec.yaml` only when they are not already covered.
- Prefer `snake_case` names for new assets.
