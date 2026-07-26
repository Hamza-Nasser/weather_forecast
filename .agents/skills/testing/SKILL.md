---
name: Testing
description: Testing patterns using flutter_test, bloc_test, and mocktail for unit tests, BLoC tests, widget tests, and navigation tests. Includes translation setup, mocking boundaries, and proportional verification strategy.
---

# Testing

## Frameworks

- `flutter_test` — widget and unit tests
- `bloc_test` — BLoC/Cubit state sequence tests
- `mocktail` — mocking and verification

Name test files `*_test.dart`.

## Setup

Call `setupTestTranslations()` before tests that evaluate translated values:

```dart
setUpAll(() {
  setupTestTranslations();
});
```

## Mocking Rules

- Mock sources, repositories, use cases, storage, analytics, and error tracking **at architectural boundaries**.
- **Do not** make real network, analytics, Firebase, Sentry, secure-storage, or platform-plugin calls in unit and widget tests.
- Register `mocktail` fallback values when matching custom value types with `any()`.

```dart
class MockMyUseCase extends Mock implements MyUseCase {}

// Register fallback for custom types
setUpAll(() {
  registerFallbackValue(MyEntity(id: '', name: ''));
});
```

## What to Test

### BLoCs and Cubits
Test emitted state sequences and important side effects:

```dart
blocTest<MyBloc, MyState>(
  'description',
  build: () => MyBloc(mockUseCase),
  act: (bloc) => bloc.add(MyEvent()),
  expect: () => [isA<MyState>()],
);
```

### Repositories
Test mapping, delegation, persistence, malformed responses, and failures.

### Widgets
Test visible behavior, interaction, loading/error states, and navigation — not private implementation details.

## Proportional Verification Strategy

| Change Type | Verification |
|------------|-------------|
| Pure logic | Targeted unit tests + analysis of touched code |
| BLoC / repository / networking | Targeted success and failure tests |
| UI / navigation | Widget/navigation tests + visual inspection |
| DI / JSON | Code generation + targeted tests + analysis |
| Dependency / native | `pub get` + analysis/tests + platform build |

Run `flutter analyze` and the full `flutter test` suite before PR handoff when practical. If platform tooling, credentials, or environment limitations prevent a check, state that clearly instead of claiming success.
