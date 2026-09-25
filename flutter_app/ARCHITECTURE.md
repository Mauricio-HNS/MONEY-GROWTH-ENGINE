# Money Growth Engine — Flutter MVP Architecture

```text
flutter_app/
├── assets/
│   └── fonts/
├── lib/
│   ├── main.dart
│   ├── routes.dart
│   ├── core/
│   │   └── financial_store.dart
│   ├── style/
│   │   └── app_style.dart
│   └── screens/
│       ├── splash.dart
│       ├── onboarding.dart
│       ├── login.dart
│       ├── register.dart
│       ├── forgot_password.dart
│       ├── financial_setup.dart
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

## MVP rules

- `routes.dart` is the single source of truth for navigation.
- `screens/` contains presentation and interaction flows.
- `core/financial_store.dart` is the temporary in-memory state layer for the MVP.
- `style/app_style.dart` owns the visual language and color tokens.
- Financial screens must update the shared store instead of keeping isolated fake totals.
- Sensitive financial actions must always pass through an explicit authorization layer.
- The current store is intentionally local/in-memory. Persistence, authentication, API, bank integrations and AI services are subsequent layers.

## Financial flow

```text
Income ─────┐
Expenses ───┼──> FinancialStore ──> Dashboard
Debt ───────┘          │
                       └──> Money Rescue / Radar
```

## Next architecture layer

When the MVP stabilizes, migrate the store behind interfaces:

```text
Presentation
     ↓
State / Controllers
     ↓
Use Cases
     ↓
Repositories
     ↓
Local DB / API / AI services
```

Do not introduce a large dependency stack until the product flows are validated.

## Palette

- Dr. White: `#F9FAFB`
- Cold Blue: `#7DE2DF`
- Laguna: `#35ACBE`
- Dark Knight: `#1A1D2E`
