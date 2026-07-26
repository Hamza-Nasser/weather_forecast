---
name: Flutter Clean Architecture
description: Layer boundaries, entity rules, use case patterns, DTO vs Model distinction, repository implementation, BLoC vs Cubit selection, and dispose lifecycle for the Flutter project following Clean Architecture.
---

# Flutter Clean Architecture

Feature code should preserve data, domain, and presentation boundaries when those layers are needed. Do not create empty layers or boilerplate for screen-only placeholders.

## Domain Layer

- Defines business entities, repository contracts, and single-purpose use cases.
- Entities are immutable, use `const` constructors where possible, and extend `Equatable` when value equality matters.
- Use cases expose `call()` and depend on repository contracts.
- Keep Flutter widgets, Dio, storage SDKs, and transport parsing out of domain logic.

Example entity pattern:
```dart
class MyEntity extends Equatable {
  const MyEntity({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
```

Example use case pattern:
```dart
@injectable
class GetSomethingUseCase {
  const GetSomethingUseCase(this._repository);
  final SomethingRepository _repository;

  Future<SomethingEntity> call(String id) => _repository.getSomething(id);
}
```

## Data Layer

- **DTOs** represent request payloads (under `data/dtos/`). Annotate with `@JsonSerializable` for serialization.
- **Models** represent remote or persisted data (under `data/models/`), extending domain entities or representing raw API responses.
- **Data Sources** (under `data/sources/`): interfaces define raw backend calls. Implementations receive `RestfulClient` in the constructor and are registered via `@Injectable(as: DataInterface)`.
- **Repositories** (under `data/repositories/`): coordinate sources, map data to domain objects, and perform feature-owned persistence. Annotated with `@Injectable(as: DomainInterface)`.
- Keep UI state, navigation, overlays, analytics presentation decisions, and `BuildContext` out of data code.

## Presentation Layer

- Screens and widgets render state and dispatch user intent.
- Use **BLoC** for event-driven or multi-step flows and **Cubit** for simple state.
- States must be immutable and `Equatable`; implement `copyWith` when state is updated incrementally.
- Inject use cases and services through constructors. Do not call the service locator from BLoCs, Cubits, repositories, sources, use cases, or leaf widgets.
- Dispose controllers, focus nodes, animation controllers, streams, and timers owned by a widget or state object.
- After an async gap, check `mounted` before using a `BuildContext` when the object may have been disposed.

## Layer Boundary Rules

- Domain must not import from data or presentation.
- Data must not import from presentation.
- Presentation depends on domain (use cases, entities) and may be wired to data through DI.
- `sl<T>()` (service locator) is only acceptable at composition roots: bootstrap, router construction, and `BlocProvider`/Cubit provider creation.
