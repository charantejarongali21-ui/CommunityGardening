# Community Gardening – Flutter Project

A beginner-friendly Flutter app demonstrating a community gardening platform.

## Included features
- Home dashboard with gardening tips and quick actions
- Browse community gardens
- Plant guide with sample plant information
- Community events
- Join/leave garden actions (local demo state)
- Profile screen
- Bottom navigation

## Requirements
- Flutter SDK (stable channel)
- VS Code
- VS Code extensions: Flutter and Dart
- Android emulator or a connected phone (or Chrome for web)

## Open and run in VS Code
1. Extract `community_gardening.zip`.
2. Open the extracted `community_gardening` folder in VS Code.
3. Open **Terminal → New Terminal**.
4. Run:
   ```bash
   flutter doctor
   flutter pub get
   flutter run
   ```
5. If VS Code asks for a device, select your Android emulator, connected phone, or Chrome.

> This starter folder contains the complete Flutter application source and package configuration. If you want Android/iOS native runner folders, run `flutter create .` once from this folder using the Flutter SDK. Then run `flutter pub get` and `flutter run`.

## Project structure
```text
community_gardening/
├── lib/
│   ├── main.dart
│   ├── data/
│   │   └── sample_data.dart
│   ├── models/
│   │   └── garden.dart
│   ├── screens/
│   │   ├── main_shell.dart
│   │   ├── home_screen.dart
│   │   ├── gardens_screen.dart
│   │   ├── plants_screen.dart
│   │   ├── events_screen.dart
│   │   └── profile_screen.dart
│   └── widgets/
│       └── garden_card.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## Important note
This is a working front-end demonstration. Login, event registration and garden membership are stored only in the app's temporary local state; no online database or real user authentication is connected. Firebase/MySQL backend integration can be added as a separate step.
