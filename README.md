# Countries App

A Flutter mobile application for browsing and learning about countries around the world. The app fetches data from the REST Countries API and provides a smooth user experience with offline support, caching, and dark mode.

## Features

- Browse Countries: View a list of all countries with flags, names, and population
- Search: Real-time search with debouncing for better performance
- Favorites: Mark countries as favorites and save them locally
- Responsive Design: Works well on mobile, tablet, and web screens
- Dark Mode: Support for light and dark themes with automatic system detection
- Offline Support: View cached data when offline
- Hero Animations: Smooth transitions between screens
- Sorting: Sort countries by name or population in ascending or descending order

## Prerequisites

You'll need the following installed:

- Flutter SDK (>=3.0.0): [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK (>=3.0.0): Comes with Flutter
- Android Studio or VS Code with Flutter extensions
- Android NDK (version 27.0.12077973 or higher) for Android builds

## Setup Instructions

### Clone the Repository

```bash
git clone <repository-url>
cd countries_app
```

### Install Dependencies

```bash
flutter pub get
```

### Generate Code Files

This project uses code generation for data models. Run this command to generate the necessary files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run the Application

For Android:
```bash
flutter run
```

For iOS (macOS only):
```bash
flutter run
```

For Web:
```bash
flutter run -d chrome
```

### Build APK (Android)

To build a release APK:

```bash
flutter build apk --release
```

The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`

## Environment Variables

No environment variables are required. The app uses the public REST Countries API which doesn't require authentication.

- API Base URL: `https://restcountries.com/v3.1/`
- No API keys needed

## Project Structure

The project follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality and utilities
│   ├── constants/           # App constants (colors, sizes, strings)
│   ├── errors/              # Custom exceptions and failures
│   ├── injection/           # Dependency injection setup
│   ├── network/             # HTTP client and network configuration
│   ├── theme/               # Theme management (light/dark)
│   ├── utils/               # Utility classes (logger, formatters, etc.)
│   └── widgets/             # Reusable widgets
│
├── features/                 # Feature modules
│   ├── countries/           # Countries feature
│   │   ├── data/            # Data layer (DTOs, data sources, repositories)
│   │   ├── domain/          # Domain layer (entities, repositories interfaces)
│   │   └── presentation/    # Presentation layer (BLoC, pages, widgets)
│   └── favorites/           # Favorites feature
│       ├── data/            # Data layer
│       ├── domain/          # Domain layer
│       └── presentation/    # Presentation layer
│
└── widgets/                 # Shared widgets across features
```

## Technology & Architecture Choices

### State Management: BLoC Pattern

I chose BLoC for state management because it separates business logic from the UI, making the codebase more maintainable and testable. The unidirectional data flow makes it easier to debug and understand the app's behavior. Business logic can be reused across different UI implementations, and BLoC classes can be unit tested independently of the UI.

The app uses the `flutter_bloc` package with separate BLoCs for:
- CountriesBloc: Manages country list, search, sorting, and favorite toggling
- CountryDetailBloc: Handles country detail page state
- FavoritesBloc: Manages favorites list and removal
- ThemeBloc: Controls app theme (light/dark/system)

### Architecture: Clean Architecture

Clean Architecture was chosen because it keeps business logic independent of frameworks, UI, and external services. Each layer can be tested in isolation, and clear boundaries make it easier to modify and extend features. It's also easier to add new features without affecting existing code.

The architecture consists of three main layers:
1. Presentation Layer: UI components, BLoCs, and widgets
2. Domain Layer: Business entities and repository interfaces
3. Data Layer: Data sources, DTOs, and repository implementations

### Dependency Injection: get_it

I used get_it for dependency injection because it's type-safe with compile-time checking, has a simple API that's easy to use, performs well with fast service location without reflection, and makes it easy to mock dependencies for testing.

### Code Generation: Freezed & json_serializable

Code generation was used to create immutable models with compile-time type safety. It automatically generates `copyWith`, `toString`, `equals`, and JSON serialization methods, reducing boilerplate code and potential bugs. The generated code follows consistent patterns.

### Network Layer: Dio

Dio was chosen over the standard `http` package because it has built-in support for interceptors (useful for logging, caching, error handling), easy request/response transformation, built-in support for canceling requests, and provides more detailed error information.

### Caching: dio_cache_interceptor

Caching was implemented to allow users to view previously loaded data without internet, reduce API calls for better performance, improve user experience with faster load times, and reduce bandwidth usage.

The app uses `dio_cache_interceptor` with Hive storage for persistent caching, configured with:
- Cache policy: Request (serves cache when available)
- Max stale: 7 days
- Cache on error: Enabled (except for 401/403)

### Local Storage: shared_preferences

shared_preferences was used for local storage because it has a simple API for key-value storage, uses platform-native storage for good performance, persists data across app restarts, and is perfect for storing user preferences and favorite country codes.

### Error Handling

The app implements a comprehensive error handling strategy with custom exceptions (NetworkException, ServerException, CacheException), custom failures (NetworkFailure, ServerFailure, CacheFailure, UnknownFailure), an error mapper that converts exceptions to user-friendly failure messages, and clear, actionable error messages displayed to users.

### UI/UX Features

The app includes shimmer effects for professional loading states, hero animations for smooth transitions on country flags, pull-to-refresh functionality, clear empty states when no data is available, user-friendly error states with retry options, and responsive layouts that adapt to different screen sizes using LayoutBuilder.

## API Integration

The app uses the [REST Countries API](https://restcountries.com/) with a two-step data fetching strategy:

1. List View: Fetches minimal data (name, flags, population, cca2)
2. Detail View: Fetches complete data when a country is selected

Endpoints used:
- `GET /v3.1/all?fields=name,flags,population,cca2` - Get all countries
- `GET /v3.1/name/{name}?fields=name,flags,population,cca2` - Search countries
- `GET /v3.1/alpha/{code}?fields=name,flags,population,cca2,capital,region,subregion,area,timezones` - Get country details

## Testing

To run tests:

```bash
flutter test
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS (macOS only)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Troubleshooting

### Android NDK Version Mismatch
If you encounter NDK version errors, make sure your `android/app/build.gradle.kts` has:
```kotlin
android {
    ndkVersion = "27.0.12077973"
}
```

### Code Generation Issues
If you have issues with generated files, try:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Cache Issues
To clear app cache, uninstall and reinstall the app, or clear app data from device settings.




