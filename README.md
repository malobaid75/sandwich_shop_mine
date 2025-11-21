# Sandwich Shop

Simple Flutter app for taking sandwich orders (counter-style).

This repository contains a small Flutter application that demonstrates a
compact ordering UI for a sandwich shop. The app allows a user to:

- Select sandwich size (six-inch or footlong)
- Choose a bread type (white, wheat, wholemeal)
- Add a short note (e.g., "no onions")
- Increase / decrease the number of sandwiches (with a configurable limit)

The app is intentionally lightweight and suitable for learning Flutter UI
patterns, simple state management, and writing small widget tests.

## Demo

Add screenshots or GIFs into `assets/screenshots/` and reference them here.

Example (replace with your images):

![Order screen placeholder](assets/screenshots/order_screen.png)

## Key Features

- Counter-based order UI with add/remove buttons
- Configurable maximum order quantity via `OrderScreen(maxQuantity: N)`
- Bread type selector and order notes
- Small, testable repository layer (`OrderRepository`) that enforces limits

## Table of contents

- [Installation & Setup](#installation--setup)
- [Usage](#usage)
- [Project structure](#project-structure)
- [Running tests](#running-tests)
- [Known issues & roadmap](#known-issues--roadmap)
- [Contributing](#contributing)
- [Contact](#contact)

## Installation & Setup

Prerequisites

- macOS / Linux / Windows (development machine)
- Flutter SDK (tested with Flutter stable on Dart SDK >= 3.9)
- For mobile targets: Xcode (iOS) or Android SDK / Android Studio (Android)

Quick start

1. Clone the repository:

```bash
git clone https://github.com/malobaid75/sandwich_shop_mine.git
cd sandwich_shop_mine
```

2. Get dependencies:

```bash
flutter pub get
```

3. Run the app (choose a device/emulator first):

```bash
flutter run
```

Notes

- To run on iOS devices or simulator, ensure Xcode and command line tools are
	installed and that you accepted the Xcode license.
- To run on Android, ensure the Android SDK and platform tools are installed
	and an Android emulator or device is available.

## Usage

When the app launches you'll find a compact order screen. Typical flows:

- Change sandwich size: use the switch between "six-inch" and "footlong".
- Choose bread: use the dropdown to pick one of the available breads.
- Add a note: type in the notes field (e.g., "no onions").
- Add / Remove: press Add to increment quantity (honors the configured
	maximum) and Remove to decrement down to zero.

Behavior notes

- Quantity is managed by `OrderRepository` (see `lib/repositories/order_repository.dart`).
- The screen shows a visual emoji count and the current note.
- `OrderScreen` constructor exposes `maxQuantity` so you can change limits when
	embedding the widget in tests or other screens:

```dart
OrderScreen(maxQuantity: 5)
```

## Running tests

This project uses the default Flutter test tooling. To run tests:

```bash
flutter test
```

There are `test/` directories in the workspace—add widget or unit tests there.

## Project structure

Top-level layout (important files/directories):

- `lib/main.dart` — app entry point and primary UI (order screen and widgets)
- `lib/repositories/order_repository.dart` — small repository enforcing
	increment/decrement and max quantity
- `lib/views/app_styles.dart` — shared text styles
- `lib/views/` and `lib/view_models/` — UI and view model code (if expanded)
- `test/` — test files
- `pubspec.yaml` — Flutter/Dart dependencies and metadata

If you open `lib/main.dart` you'll find the main widgets:

- `App` — root `MaterialApp`
- `OrderScreen` — stateful screen that wires UI to `OrderRepository`
- `OrderItemDisplay` — small stateless widget that shows the sandwich summary
- `StyledButton` — reusable button widget used for Add / Remove

## Dependencies

This project uses only the Flutter SDK and `cupertino_icons` per the
`pubspec.yaml`. No additional external packages are required.

## Known issues & roadmap

- No persistent storage: orders are ephemeral in-memory only.
- No backend integration or user accounts.
- UI is minimal and intended as a learning/demo app.

Future improvements

- Add persistence (local DB or backend)
- Add order summary / checkout flow
- Add accessibility improvements and localization
- Add screenshots and automated CI checks

## Contributing

Contributions are welcome. A simple workflow:

1. Fork the repository
2. Create a branch for your feature/fix
3. Add tests for new behavior
4. Open a pull request with a clear description

Please follow existing code style and add small, focused commits.

## Contact

- Author: Mohammed
- Email: Mohamad.m.alobaid75@gmail.com
- Other contact:  

---

If you'd like, I can also add a small set of widget tests (e.g., verify
increment/decrement boundaries and UI behavior) or insert a screenshot into
the repo and wire it into this README. Tell me which you'd prefer next.
