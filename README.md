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

Before starting, make sure you have these installed:

- Flutter SDK version 3.0.0 or higher (tested with 3.32.8)
- Dart SDK version 3.0.0 or higher (tested with 3.8.1, comes with Flutter)
- Android Studio or VS Code with Flutter extensions
- Android NDK version 27.0.12077973 for Android builds
- Java 11 or higher for Android development
- Kotlin support for Android builds

## Setup Instructions

Follow these steps to run the project from source code:

Step 1: Clone the repository
- Open your terminal and run: git clone <repository-url>
- Navigate to the project folder: cd countries_app

Step 2: Verify Flutter installation
- Run: flutter doctor
- This checks your Flutter setup and shows any missing dependencies
- Make sure all checks pass before continuing

Step 3: Install dependencies
- Run: flutter pub get
- This downloads all required packages listed in pubspec.yaml

Step 4: Generate code files
- Run: flutter pub run build_runner build --delete-conflicting-outputs
- This is required because the project uses code generation for data models
- It generates the necessary .freezed.dart and .g.dart files
- Important: You must run this before the app can compile
- If you modify any data models later, run this command again

Step 5: Configure Android NDK (for Android builds only)
- The project is already configured to use NDK version 27.0.12077973
- This is set in android/app/build.gradle.kts
- If you get NDK errors, make sure this version matches your installed NDK

Step 6: Run the application
- Make sure you have a device connected or emulator running (for mobile)
- Or have Chrome installed (for web)
- For Android: Run flutter run
- For iOS (macOS only): Run flutter run
- For Web: Run flutter run -d chrome
- Note: First run may take a few seconds as it initializes the service locator and cache

Step 7: Build APK for Android (optional)
- To create a release APK: flutter build apk --release
- The APK file will be at: build/app/outputs/flutter-apk/app-release.apk

## Environment Variables

No environment variables are required. The app uses the public REST Countries API which doesn't require authentication.

- API Base URL: `https://restcountries.com/v3.1/`
- No API keys needed
- No configuration files required

## Special Setup Requirements

Code Generation
- This project uses Freezed and json_serializable for data models
- You must run the code generation command before compiling
- Generated files are not in the repository, so you need to create them
- Run: flutter pub run build_runner build --delete-conflicting-outputs
- Run this again if you modify files in lib/features/countries/data/models/
- Or if you change any file with @freezed or @JsonSerializable annotations

Service Locator
- The app uses get_it for dependency injection
- Initialization happens automatically in main.dart
- If you see dependency errors, check that setupServiceLocator() is called in main()

Cache Directory
- The app creates a cache folder automatically on first run
- Uses path_provider to store cached data
- Cache persists across app restarts
- No manual setup needed

Android Requirements
- Minimum SDK: As set by Flutter (usually 21 or higher)
- Target SDK: As set by Flutter
- NDK version: 27.0.12077973 (already configured)
- Java: Version 11 or higher required
- Kotlin: Required for Android builds

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

## Future Improvements

If I had more time, here are some features and improvements I would add:

Testing
- Add comprehensive unit tests for BLoCs and business logic
- Implement widget tests for UI components
- Add integration tests for critical user flows
- Set up test coverage reporting

Internationalization
- Add support for multiple languages
- Translate all user-facing strings
- Support for right-to-left languages
- Localized number and date formats

Enhanced Features
- Display currencies and languages for each country
- Add country comparison feature to compare multiple countries side by side
- Implement search history to remember recent searches
- Add export functionality to share favorites list
- Create home screen widgets for quick access to favorites

User Experience
- Add pull-to-refresh on detail page
- Implement swipe gestures for navigation
- Add haptic feedback for interactions
- Improve empty states with helpful suggestions
- Add onboarding tutorial for first-time users

Performance
- Implement image caching for country flags
- Add pagination or lazy loading for large country lists
- Optimize list rendering with better item builders
- Add performance monitoring and analytics

Accessibility
- Improve screen reader support
- Add high contrast mode support
- Ensure all interactive elements are keyboard accessible
- Add text scaling support for better readability

Offline Features
- Add offline map integration
- Cache country images for offline viewing
- Implement sync mechanism for favorites across devices
- Add offline search functionality

Data Visualization
- Add charts and graphs for country statistics
- Create visual comparisons for population, area, etc.
- Implement timeline view for country data changes
- Add interactive maps showing country locations

Developer Experience
- Add comprehensive API documentation
- Create developer guide for extending features
- Implement CI/CD pipeline for automated testing and deployment
- Add code quality checks and automated formatting

