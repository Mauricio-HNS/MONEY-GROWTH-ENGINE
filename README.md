# MONEY GROWTH ENGINE

<p align="center">
  <img width="1408" height="768" alt="Money Growth Engine" src="https://github.com/user-attachments/assets/24b8eadf-866c-463f-b6e1-f6b38203f8c6" />
</p>

<h2 align="center">Your money. Your next move.</h2>

<p align="center">
  <strong>Financial Recovery Agent</strong><br>
  An intelligent financial management experience designed to help you understand, recover, optimize and grow your money.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Dart-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Architecture-Modular-111827?style=for-the-badge" alt="Architecture">
  <img src="https://img.shields.io/badge/Status-In%20Development-E50914?style=for-the-badge" alt="Status">
</p>

---

## What is Money Growth Engine?

Money Growth Engine is being built around a simple idea:

> **Don't just track your money. Find what your money can do next.**

Instead of treating personal finance as a collection of spreadsheets and static numbers, the app organizes the user's financial life into specialized areas and actionable financial agents.

The objective is to help users identify:

- Money being unnecessarily lost
- Opportunities to reduce expenses
- Ways to increase income
- Debt reduction opportunities
- Investment and portfolio scenarios
- Underused assets
- Business and revenue opportunities
- Tax-related opportunities
- Financial opportunities that may be difficult to see manually

---

## The Money Team

The application is structured around specialized financial agents.

| Agent | Purpose |
|---|---|
| **Money Rescue** | Find money that may be leaking from your financial life |
| **Income** | Explore opportunities to increase income |
| **Expenses** | Identify and reduce unnecessary spending |
| **Debt** | Build strategies for debt reduction |
| **Investments** | Analyze investment possibilities and scenarios |
| **Portfolio** | Monitor allocation and financial risk |
| **Business** | Identify potential business and revenue opportunities |
| **Assets** | Find ways to make idle assets useful |
| **Tax** | Organize tax-related opportunities and information |
| **Opportunity Radar** | Scan the broader financial picture for opportunities |

The idea is to make the application feel less like a financial spreadsheet and more like a **personal financial command center**.

---

## Complete First-Launch Experience

Money Growth Engine is designed around the complete user journey rather than dropping a new user directly onto a dashboard.

### 01 — Splash

A strong visual introduction to the Money Growth Engine brand.

### 02 — Onboarding

Three introductory stages explain the core concept:

**Find hidden money → Build your money team → Turn insight into action**

### 03 — Account

Users can:

- Sign in
- Create an account
- Recover a forgotten password

### 04 — Financial Setup

The application collects the initial financial information needed to personalize the experience.

### 05 — Financial Dashboard

The dashboard brings together the user's financial indicators and the available money agents.

---

## Dashboard

The home experience is designed around actionable information rather than simply displaying numbers.

Core indicators include:

- Cash flow
- Potential money to recover
- Income
- Debt

From the dashboard, the user can move directly into each specialized financial area.

---

## Architecture

The Flutter application keeps navigation centralized and separates screens, styling and core financial state.

```text
flutter_app/
│
├── lib/
│   ├── main.dart
│   ├── routes.dart
│   │
│   ├── core/
│   │   └── financial_store.dart
│   │
│   ├── style/
│   │   ├── app_style.dart
│   │   └── brand.dart
│   │
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
│       └── radar.dart
│
└── assets/
```

### Centralized routes

Application navigation is maintained in:

```text
lib/routes.dart
```

This keeps the application's navigation map in one place and makes adding new flows easier.

### Centralized visual identity

Brand elements are centralized in:

```text
lib/style/brand.dart
```

This provides reusable branding components such as:

- Official Money Growth Engine artwork
- Brand mark
- Application name
- Shared visual identity

---

## Product Philosophy

Money Growth Engine follows five principles:

### ANALYZE

Understand where the money is going.

### FIND

Discover financial leaks and overlooked opportunities.

### PLAN

Turn information into concrete financial actions.

### EXECUTE

Move from analysis to decisions and actions.

### GROW

Continuously improve the user's financial position.

---

## Technology

The current application is being developed with:

- **Flutter**
- **Dart**
- Material UI
- Centralized route management
- Modular screen architecture
- Reusable design components
- Centralized financial state
- Brand-specific visual system

The architecture is intentionally being developed so that future services can be introduced without rebuilding the entire application.

---

## Current Development

This repository is an active product under development.

The current focus is the application foundation:

- Product identity
- Complete onboarding flow
- Authentication flow
- Financial setup
- Financial dashboard
- Specialized financial agents
- Reusable architecture
- Brand system
- Responsive Flutter UI

Future iterations can introduce persistent storage, authentication services, AI-powered financial analysis, external financial integrations, notifications and automated financial agents.

---

## Vision

Money Growth Engine is being designed to evolve from a financial dashboard into an **AI-powered personal financial workforce**.

The long-term direction is to give each financial domain a specialized intelligence layer capable of continuously analyzing information, identifying opportunities and helping the user decide what deserves attention next.

```text
                 MONEY GROWTH ENGINE
                          │
              ┌───────────┴───────────┐
              │   FINANCIAL COMMAND   │
              │        CENTER         │
              └───────────┬───────────┘
                          │
       ┌──────────┬───────┼───────┬──────────┐
       │          │       │       │          │
     RESCUE     INCOME   DEBT   ASSETS   INVESTMENTS
       │          │       │       │          │
       └──────────┴───────┼───────┴──────────┘
                          │
                  OPPORTUNITY RADAR
                          │
                     PLAN → ACT → GROW
```

---

## Repository

**MONEY-GROWTH-ENGINE**

Built with Flutter and Dart.

The goal is simple:

**Understand your money. Recover what is being lost. Find what comes next. Grow.**
