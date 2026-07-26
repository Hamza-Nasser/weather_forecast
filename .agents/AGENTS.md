# Project Rules

These rules apply to every task in this repository.

## Required Skills — Read Before Every Task

Before starting any task, identify which of the following skills apply and read their SKILL.md files. Most tasks touch multiple skills. When in doubt, read the skill.

| When the task involves… | Read this skill |
|------------------------|-----------------|
| Creating or modifying feature layers (data/domain/presentation) | `.agents/skills/flutter-clean-architecture/SKILL.md` |
| UI work, screens, widgets, styling, theming | `.agents/skills/ui-design-system/SKILL.md` |
| Adding or changing routes, navigation, redirects | `.agents/skills/navigation/SKILL.md` |
| API calls, endpoints, networking, error handling | `.agents/skills/networking/SKILL.md` |
| User-facing strings, translations, assets | `.agents/skills/localization/SKILL.md` |
| Registering or injecting dependencies | `.agents/skills/dependency-injection/SKILL.md` |
| Writing or updating tests | `.agents/skills/testing/SKILL.md` |
| Analytics events, error tracking, Sentry | `.agents/skills/analytics/SKILL.md` |
| Form inputs, validation, formz | `.agents/skills/forms-validation/SKILL.md` |
| Widget structure, class widgets, component files | `.agents/skills/widget-architecture/SKILL.md` |
| Scaffolding a new feature from scratch | `.agents/skills/add-new-feature/SKILL.md` |
| Migrating or verifying a feature from a legacy codebase | `.agents/skills/legacy-migration/SKILL.md` |

## Task Workflow

Before changing code:

- Read the target file, its nearest related files, and its existing tests.
- Inspect current repository state and preserve unrelated user changes.
- Keep the change focused on the requested behavior. Do not silently fix, rename, move, or reformat unrelated code.
- Follow an established local pattern only when it agrees with this guide. Placeholder or legacy code is not automatically precedent.
- Do not add a dependency when the existing SDK, a current package, or a small local implementation is sufficient.

While working:

- Prefer small, reviewable changes with explicit layer boundaries.
- Format only touched Dart files; do not run repository-wide formatting in a dirty worktree.
- Run the narrowest useful validation first, then broaden verification in proportion to the change.
- Never commit, push, create a pull request, alter signing, or rotate configuration unless the task explicitly requests it.

Before handing off:

- Review the final diff for accidental changes, generated-file correctness, secrets, and user-facing strings.
- Report behavior changed, tests or commands run, and any validation that could not be completed.

## Coding Style and Imports

- Use `snake_case.dart` filenames, `UpperCamelCase` types, and `lowerCamelCase` members.
- Prefer `const`, `final`, immutable collections or state, early returns, and small focused widgets.
- Never use widget helper functions (`Widget _buildX(...)`); always use standalone `StatelessWidget` / `StatefulWidget` class widgets.
- Put screen components into separate files inside a `components/` directory (e.g., `lib/features/weather/presentation/components/`).
- Use `package:weather_app/...` imports across project areas and relative imports for tightly coupled files in the same local module, following nearby code.
- Avoid `dynamic` at public boundaries when the response can be validated and typed.
- Do not suppress analyzer warnings without documenting a concrete reason.
- Comments should explain constraints or non-obvious decisions, not restate the code.

## Generated Code — Do Not Edit

Never hand-edit:

- `lib/configurations/di/injector.config.dart`
- Generated `*.g.dart` files
- `.metadata`
- `.flutter-plugins-dependencies` or other Flutter tool output

Generated injector and JSON files are tracked. When their generator inputs change, regenerate them with `dart run build_runner build --delete-conflicting-outputs`, inspect the output, and include the resulting changes. `pubspec.lock` is also tracked and should accompany intentional dependency changes.

## Environment and Secrets

- Runtime service keys are declared in `.env.example` and read with `String.fromEnvironment`.
- Always run with `flutter run --dart-define-from-file=.env`.
- Never print populated environment values in logs, tests, screenshots, or task output.
- Never commit a populated `.env`. When environment keys change, update `.env.example` with empty values.
- `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` are tracked operational configuration. Do not replace, regenerate, expose, or reconfigure them unless the task explicitly requires it.

## Commits and Pull Requests

- Use Conventional Commit prefixes: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:` with focused imperative subjects.
- Keep commits scoped to one coherent change.
- Before handing off, check the diff for secrets and unintended modifications to native configuration.

## Project Structure Reference

- `lib/main.dart` — process bootstrap and SDK initialization.
- `lib/app.dart` — root application widget, themes, localization delegates, router, and app-wide providers.
- `lib/configurations/di/` — GetIt and Injectable setup.
- `lib/configurations/navigation/` — AppRoute, GoRouter configuration, shells, and route guards.
- `lib/configurations/ui/` — palettes, themes, typography, dimensions, and responsive helpers.
- `lib/core/` — reusable infrastructure (networking, localization, services, resources, exceptions, string helpers, validators).
- `lib/features/` — feature modules.
- `lib/shared/` — cross-feature entities, mappings, session state, and reusable UI. Not a feature module.
- `test/` — unit, BLoC, navigation, and widget tests.
- `assets/` — images, SVG sources, fonts, and translations.

## Build and Development Commands

- `flutter pub get` — install or refresh dependencies.
- `flutter run --dart-define-from-file=.env` — run with local service configuration.
- `flutter analyze` — run the configured flutter_lints analysis.
- `dart format PATH...` — format only files in task scope.
- `flutter test TEST_PATH` — run the nearest relevant tests first.
- `flutter test` — run the full Dart/Flutter suite.
- `flutter test --coverage` — generate `coverage/lcov.info` when coverage is requested.
- `dart run build_runner build --delete-conflicting-outputs` — regenerate Injectable and JSON serialization output.

Run code generation after changing Injectable registrations, `@JsonSerializable` models, part declarations, or other generator inputs. Do not use `flutter clean` as a routine troubleshooting step and do not delete caches or lockfiles merely to retry a build.
