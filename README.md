# Weather App

A mobile Flutter weather application for Android and iOS with a
glassmorphic UI, English/Arabic support, offline cache fallback, and
real-time weather data from WeatherAPI.com.

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- A [WeatherAPI](https://www.weatherapi.com/) API key

### Environment Setup

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Add your API key to `.env`:
   ```
   WEATHER_API_KEY=your_api_key_here
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run --dart-define-from-file=.env
   ```

> **Important:** Never commit the `.env` file. It is listed in `.gitignore`. Only `.env.example` (with empty values) should be tracked.

`WEATHER_API_KEY` is compiled into the Android/iOS application by
`--dart-define-from-file`. Like every key shipped in a client app, it can be
extracted by a determined user. Restrict and monitor the key in the provider
dashboard, and never print it in logs.

The Android and iOS bundle identifier is `com.tocaan.weatherdemo`.

## Project Structure

```
lib/
├── app.dart                     # Root widget, themes, localization, router
├── main.dart                    # Bootstrap and SDK initialization
├── configurations/
│   ├── di/                      # GetIt + Injectable dependency injection
│   ├── navigation/              # GoRouter, AppRoute enum, guards
│   └── ui/                      # Palette, theme, typography, dimensions
├── core/                        # Networking, caching, services, exceptions
├── features/
│   ├── weather/                 # Weather feature (data/domain/presentation)
│   └── settings/                # Settings feature (language selection)
├── shared/ui/                   # Reusable widgets (UiText, UiButton, etc.)
└── l10n/                        # Localization (en, ar)
```

## Localization

The app supports English and Arabic. Translation files are in `lib/l10n/`:
- `app_en.arb` — English
- `app_ar.arb` — Arabic

After modifying `.arb` files, regenerate with:
```bash
flutter gen-l10n
```

## Supported Platforms

This project intentionally supports Android and iOS only.

Weather data is provided by WeatherAPI.com. Forecasts are informational and
may differ from actual conditions.
