---
name: Add New Feature
description: Step-by-step workflow for scaffolding a new feature module in the project, including folder structure, domain layer, data layer, presentation layer, dependency injection, and route registration.
---

# Adding a New Feature

Follow these steps to scaffold a new feature module.

## 1. Create Feature Folder Structure

```
lib/features/<feature_name>/
├── data/
│   ├── dtos/           # Request payloads (@JsonSerializable)
│   ├── models/         # API response models
│   ├── repositories/   # Repository implementations
│   └── sources/        # Remote/local data source interfaces + implementations
├── domain/
│   ├── entities/       # Business objects (Equatable, const constructors)
│   ├── repositories/   # Repository interface contracts
│   └── usecases/       # Single-responsibility use cases with call()
└── presentation/
    ├── bloc/           # BLoC or Cubit + events + states
    ├── screens/        # Page-level widgets
    └── widgets/        # Feature-specific sub-components
```

## 2. Domain Layer

- Create the entity extending `Equatable` with `const` constructor.
- Define the repository interface (abstract class).
- Create use case classes annotated with `@injectable`, exposing a `call()` method.

## 3. Data Layer

- Create DTOs or request models if needed (annotate with `@JsonSerializable`).
- Create data source interface and implementation:
  - Implementation receives `RestfulClient` via constructor.
  - Register with `@Injectable(as: DataSourceInterface)`.
- Implement the repository interface:
  - Inject remote/local data sources via constructor.
  - Register with `@Injectable(as: RepositoryInterface)`.

## 4. Presentation Layer

- Create a BLoC (for multi-event flows) or Cubit (for simple state updates).
- States must extend `Equatable` and implement `copyWith`.
- Design screens using `Ui*` components from the design system.
- Account for loading, error, empty, disabled, and retry states.

## 5. Dependency Injection

Run code generation to wire up the new classes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 6. Navigation

- Add routes to the `AppRoute` enum in `app_routes.dart`.
- Register in `AppRouter._routes` under the correct route tree.
- If route access depends on auth state, ensure `RouteGuards` handles it.

## 7. Localization

- Add all user-facing strings to `en.json` and `ar.json`.
- Declare keys in `TranslationKeys`.
- Render with `.tr()`.

## 8. Testing

- Create tests under `test/features/<feature_name>/` mirroring the source structure.
- Write BLoC tests, repository tests, and widget tests as appropriate.
