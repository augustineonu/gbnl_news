# gbnl_news

This is a Flutter-based news application replicated from a provided test project. It fetches and displays news articles from an external API and follows a clean architecture structure using the GetX state management library.


##  Getting Started

```bash
# Install Flutter dependencies via FVM
fvm install
fvm flutter pub get

# Run the app
fvm flutter run

##  Project Setup

###  Requirements
- Flutter SDK (via FVM): `3.24.1`
- Dart 3.x
- Android Studio / VS Code
- Emulator or physical device (iOS/Android)

### Dependencies
- [`get`](https://pub.dev/packages/get)
- [`http`](https://pub.dev/packages/http)
- [`permission_handler`](https://pub.dev/packages/permission_handler)
- [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications)
- More listed in `pubspec.yaml`

###  Folder Structure

lib/
├── features/
│ ├── auth/ # For authentication logic (placeholder)
│ └── news_feed/
│ ├── data/
│ │ ├── model/ # Data models (e.g., news article)
│ │ └── repository/ # API call logic
│ ├── view_model/ # GetX ViewModel for state management
│ ├── pages/ # UI pages
│ └── widget/ # Reusable UI components
├── helpers/
│ ├── routing_config.dart # App navigation
│ ├── api_response_model.dart # Common API response model
│ ├── exception_helper.dart # API error handling
│ └── network.dart # API base config
├── styles/ # App theme/style files (optional)
├── utils/ # Utility helpers
└── main.dart # App entry point


##  Features

- 🔄 Fetches live news from [Finnhub.io](https://finnhub.io/)
- 📄 Displays news in list format
- 🌐 Tap on a news item to open the full article in a browser
- 🔔 Requests notification permissions
- ➡️ Redirects based on permissions after login




