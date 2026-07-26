---
name: Navigation
description: GoRouter navigation setup, AppRoute enum, route registration, and best practices.
---

# Navigation

Navigation uses GoRouter configured in `lib/configurations/navigation/app_router.dart`.

## Adding Routes

1. Declare route names and paths in the `AppRoute` enum in `app_routes.dart`.
2. Register routes in `AppRouter._routes` and place them in the correct route tree.

## Navigation APIs

- Use GoRouter navigation (`context.go()`, `context.push()`, etc.) for application routes.
- Use `Navigator` only for local back, dialog, or sheet behavior where appropriate.

## Invariants to Preserve

When adding or changing routes, always preserve:

- Correct shell membership and selected navigation destination.
- State lifetime across multi-screen flows.

Add or update navigation and visible behavior tests whenever route access, shell placement, or session transitions change.
