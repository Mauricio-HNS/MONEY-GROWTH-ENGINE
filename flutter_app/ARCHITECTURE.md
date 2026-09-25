# Money Growth Engine — Flutter Architecture

```text
flutter_app/
├── assets/
│   └── fonts/
├── lib/
│   ├── main.dart
│   ├── routes.dart
│   ├── style/
│   │   └── app_style.dart
│   └── screens/
│       ├── home.dart
│       ├── money_rescue.dart
│       ├── income.dart
│       ├── expenses.dart
│       ├── debt.dart
│       ├── investments.dart
│       ├── portfolio.dart
│       ├── business.dart
│       ├── assets.dart
│       ├── tax.dart
│       ├── radar.dart
│       └── screen_shell.dart
└── pubspec.yaml
```

## Rules

- `routes.dart` is the single source of truth for navigation.
- `screens/` contains presentation screens only.
- `style/app_style.dart` owns the visual language and color tokens.
- `assets/fonts/` is reserved for production font files.
- Business logic should later live outside `screens/`, separated into `models/`, `services/`, `repositories/`, `state/` and `features/` as the app grows.
- Sensitive financial actions must always pass through an explicit authorization layer.

## Palette

- Dr. White: `#F9FAFB`
- Cold Blue: `#7DE2DF`
- Laguna: `#35ACBE`
- Dark Knight: `#1A1D2E`
