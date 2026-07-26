---
name: Forms Validation
description: Form validation using formz, FormzInput extension, validation error enums with TranslationKeys, and testing patterns for form inputs in the project.
---

# Forms and Validation

## Pattern

Use `formz` and the existing validators for form state. Validators live in `lib/core/validators/`.

## Creating a New Input Validator

1. Extend `FormzInput<T, E>` with typed value and error parameters.
2. Create a validation error enum with a `.message` getter returning the translated error string via `TranslationKeys`.
3. Keep formatting and validation separate.

```dart
enum MyInputError {
  empty,
  invalid;

  String get message {
    switch (this) {
      case empty:
        return TranslationKeys.validationRequired.tr();
      case invalid:
        return TranslationKeys.validationInvalid.tr();
    }
  }
}

class MyInput extends FormzInput<String, MyInputError> {
  const MyInput.pure() : super.pure('');
  const MyInput.dirty([super.value = '']) : super.dirty();

  @override
  MyInputError? validator(String value) {
    if (value.isEmpty) return MyInputError.empty;
    if (!_isValid(value)) return MyInputError.invalid;
    return null;
  }
}
```

## Testing

Cover all input boundaries with unit tests:
- **Required** — empty input returns error
- **Invalid** — malformed input returns error
- **Valid** — correct input returns null
- **Boundary** — edge cases (min/max length, special characters)
