---
name: Analytics
description: Analytics and error tracking using AnalyticsDispatcher, AnalyticsEvents, and SentryService. Rules for PostHog, Customer.io, Adjust integration and session lifecycle consistency.
---

# Analytics and Error Tracking

## Product Analytics

- Use `AnalyticsDispatcher` and `AnalyticsEvents` for product analytics.
- **Do not** call PostHog, Customer.io, or Adjust directly from feature code.
- Add or change provider-specific behavior centrally through the existing analytics services.

## Session Lifecycle

Keep identify, profile-update, completion, failure, and reset behavior consistent with the session lifecycle. Do not introduce new personal or sensitive analytics properties unless the task explicitly requires them and their use is reviewed.

## Error Tracking

- Use `SentryService` rather than calling the Sentry SDK directly from features.
- Report unexpected failures through `SentryService` where the surrounding flow does so.
- Do not silently swallow failures.

## Privacy

- Never log tokens, OTPs, credentials, response headers, or full sensitive payloads.
- Do not introduce new personal or sensitive analytics properties without explicit task requirement and review.
