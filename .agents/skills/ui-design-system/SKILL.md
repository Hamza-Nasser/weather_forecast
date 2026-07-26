---
name: UI Design System
description: Custom UI components (UiText, UiButton, UiInputField, etc.), theme extensions (colorPalette, appTypography), design tokens (AppSpacing, AppBorderRadius, AppIconSize, AppDuration), responsive layout, accessibility, RTL support, and state handling for screens and widgets.
---

# UI Design System

## Custom Components — Always Use These

Before creating UI, inspect `lib/shared/ui/widgets/`. **Never use raw Flutter material widgets directly.** Always use the app's custom design components:

| Instead of | Use |
|-----------|-----|
| `Text` | `UiText` |
| `ElevatedButton`, `TextButton`, etc. | `UiButton` |
| `TextField` | `UiInputField` |
| Picker widgets | `UiPickerField` |
| Tab bars | `UiSegmentedTab` |

Additional shared components:
- `UiSurface`, `UiAppBar`, `UiDialog`, `UiScrollbar`, `UiSvg`, `CircularLoading`
- Existing bottom-sheet and Cupertino-sheet containers

Raw Flutter layout and platform widgets are acceptable where no design-system abstraction exists, but do not recreate a supported component's styling inside a feature. Extend an existing shared component when the design case is reusable.

## Theme Extensions — Colors and Typography

Do **NOT** use hardcoded colors or text styles. Access custom properties via context:

```dart
// Colors
Theme.of(context).colorPalette.primary
Theme.of(context).colorPalette.white
Theme.of(context).colorPalette.dark02

// Typography
Theme.of(context).appTypography.headlineBold
Theme.of(context).appTypography.titleMedium
Theme.of(context).appTypography.baseRegular
```

### Locale-Aware Fonts
Fonts are set dynamically at runtime based on the language:
- **Tajawal** (`arabicFontFamily`) for Arabic locales
- **Nunito** (`latinFontFamily`) for Latin/English locales

## Design Tokens

Use tokens from `lib/configurations/ui/dimensions/app_dimensions.dart` instead of magic numbers:

### Spacing (`AppSpacing`)
| Token | Value |
|-------|-------|
| `AppSpacing.xs` | 4.0 |
| `AppSpacing.s` | 8.0 |
| `AppSpacing.m` | 12.0 |
| `AppSpacing.l` | 16.0 |
| `AppSpacing.xl` | 20.0 |
| `AppSpacing.xxl` | 24.0 |
| `AppSpacing.xxxl` | 32.0 |

### Border Radius (`AppBorderRadius`)
- `AppBorderRadius.circularXxs`
- `AppBorderRadius.circularXs`
- `AppBorderRadius.circularS`
- `AppBorderRadius.circularM`
- `AppBorderRadius.circularL`
- `AppBorderRadius.circularXl`

### Icon Size (`AppIconSize`)
| Token | Value |
|-------|-------|
| `AppIconSize.s` | 16.0 |
| `AppIconSize.m` | 20.0 |
| `AppIconSize.l` | 24.0 |

### Animation Duration (`AppDuration`)
| Token | Value |
|-------|-------|
| `AppDuration.fast` | 200ms |
| `AppDuration.normal` | 250ms |
| `AppDuration.slow` | 300ms |

### Responsive Layout (`ResponsiveContext`)
Use the `ResponsiveContext` extension on `BuildContext`:
```dart
context.screenHeight
context.screenWidth
context.isKeyboardOpen
context.percentHeight(ratio)
```

## UI State Handling

UI work should account for all applicable states:
- **Loading** — show loading indicators
- **Error** — display error messages with retry options
- **Empty** — show empty state illustrations/messages
- **Disabled** — grey out / prevent interaction
- **Retry** — allow user to retry failed operations

## Accessibility and Layout

Always preserve:
- `SafeArea` and keyboard behavior
- Text scaling
- Tap target accessibility (minimum 48x48)
- Semantic labels
- Arabic RTL layout
- The configured theme (light/dark)

Existing placeholder screens with hardcoded labels or magic values are temporary and must not be copied as preferred style.
