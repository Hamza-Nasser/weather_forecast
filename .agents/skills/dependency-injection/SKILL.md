---
name: Dependency Injection
description: GetIt and Injectable dependency injection setup, registration annotations (@injectable, @singleton, @LazySingleton), service locator usage rules, and code generation workflow.
---

# Dependency Injection

The project uses `get_it` and code generation via `injectable`.

## Registration

Annotate your classes with the appropriate Injectable annotations:

```dart
// Simple injectable (created each time)
@injectable
class MyUseCase { ... }

// Singleton (single instance for app lifetime)
@singleton
class MyService { ... }

// Lazy singleton implementing an interface
@LazySingleton(as: MyInterface)
class MyServiceImpl implements MyInterface { ... }

// Injectable implementing an interface
@Injectable(as: MyRepository)
class MyRepositoryImpl implements MyRepository { ... }
```

**Prefer constructor injection** over any other form of dependency resolution.

## Service Locator Usage

Use `sl<T>()` **only** at composition roots:

- Bootstrap / `main.dart`
- Router construction
- `BlocProvider` or Cubit provider creation

**Hidden service-locator access inside business or UI implementation code makes dependencies and tests unreliable.** Do not use `sl<T>()` inside BLoCs, Cubits, repositories, sources, use cases, or leaf widgets.

## Code Generation

After adding or updating dependencies, regenerate the DI wiring:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This updates `lib/configurations/di/injector.config.dart`. **Never hand-edit this file.**

Run code generation after changing:
- Injectable registrations
- `@JsonSerializable` models
- `part` declarations
- Other generator inputs
