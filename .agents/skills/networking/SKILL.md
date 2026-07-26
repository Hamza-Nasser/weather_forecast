---
name: Networking
description: RestfulClient networking, endpoint management, Dio interceptors, error mapping, UserFriendlyException hierarchy, TokensSecureStorage, and preferences abstractions for API calls and error handling.
---

# Networking

## Endpoint Management

- Put endpoint paths in the `Endpoints` class.
- Make feature network calls only from injected remote sources through `RestfulClient`.
- Do not instantiate `Dio` or catch `DioException` in feature repositories.

## RestfulClient

All network calls go through `RestfulClient` (accessed via `sl<RestfulClient>()`). The `DioRestfulClient` implementation includes interceptors that handle:

- Authorization headers
- Language headers
- Retry logic
- Refresh token flow
- Error mapping

**Do not manually duplicate** any of this behavior in feature code.

## Error Mapping

The centralized network code translates transport failures into application exceptions:

| Transport Error | Application Exception |
|----------------|----------------------|
| `SocketException` | `NoInternetConnectionException` |
| HTTP 400 | `BadRequestException` |
| HTTP 401 | `UnauthorizedException` |
| HTTP 404 | `NotFoundException` |
| HTTP 500 | `ServerException` |

Let exceptions bubble up as `UserFriendlyException` subclasses. Handle them in the BLoC/Cubit layer using `try/catch` on `UserFriendlyException`.

## Response Handling

- Validate and unwrap response envelopes at the data boundary.
- Map responses to typed models or domain entities.
- Do not silently swallow failures, leak raw backend messages to users, or log tokens, OTPs, credentials, response headers, or full sensitive payloads.

## Storage

- Store access and refresh tokens **only** through `TokensSecureStorage`.
- Use the existing preferences abstractions rather than calling `SharedPreferences` directly from features.

## Error Presentation

Presentation code should:
- Expose safe, localized messages to users.
- Report unexpected failures through `SentryService` where the surrounding flow does so.
