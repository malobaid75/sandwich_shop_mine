# Navigation Drawer & Responsive Navigation

## Feature Description

Add a responsive, app-wide navigation Drawer and alternate wide-screen navigation for the Sandwich Shop app. Centralize navigation in a shared `AppScaffold` to reduce duplicated Scaffold/Drawer code across screens.

## User Stories

- As a user, I can open the app menu from any screen to navigate to Order, Cart, Profile, or About pages.
- As a user on a wide screen (tablet/desktop), I see a persistent navigation rail/sidebar and do not need to open a Drawer.
- As a developer, I want a single `AppScaffold` wrapper so screens don't duplicate navigation code.

## Acceptance Criteria

- [ ] AppScaffold exists at `lib/views/app_scaffold.dart` and provides the Drawer/NavigationRail and AppBar wiring.
- [ ] On narrow screens (width < 700px):
  - AppBar shows a leading IconButton with Key('nav_open_button').
  - Tapping it opens a Drawer with Key('nav_drawer').
  - Drawer contains ListTiles with Keys: 'nav_drawer_order', 'nav_drawer_cart', 'nav_drawer_profile', 'nav_drawer_about'.
  - Tapping an item closes the Drawer and navigates (named routes).
- [ ] On wide screens (width >= 700px):
  - No AppBar hamburger button; a persistent NavigationRail or sidebar with Key('nav_rail') is shown.
  - Selecting an item navigates and highlights the selected item.
- [ ] All navigation-related interactive widgets include the Keys listed above to support deterministic widget tests.

## Subtasks

1. Create or update `lib/views/app_scaffold.dart`:
   - Signature: `AppScaffold({required String title, required Widget child, bool showBack = false})`.
   - Implement responsive behavior using `MediaQuery` / `LayoutBuilder`.
   - Provide Drawer (narrow) and NavigationRail/persistent sidebar (wide) with the required Keys and semantics.
2. Migrate screens to use `AppScaffold` (wrap content):
   - `lib/views/order_screen.dart`
   - `lib/views/cart_screen.dart`
   - `lib/views/profile_screen.dart`
   - `lib/views/about_screen.dart`
   - `lib/views/checkout_screen.dart`
3. Ensure named routes exist in `lib/main.dart`: '/', '/cart', '/profile', '/about', '/checkout'.
4. Add widget tests under `test/views/navigation_drawer_test.dart` covering:
   - Drawer open/navigation on narrow screens.
   - Drawer closes after navigation.
   - Persistent navigation rail visible on wide screens (emulate large MediaQuery size).
5. Run `flutter analyze` and `flutter test`, fix issues.

## Test Plan / Keys

- Keys to use:
  - `Key('nav_open_button')` — AppBar leading button that opens Drawer
  - `Key('nav_drawer')` — Drawer container
  - `Key('nav_drawer_order')`
  - `Key('nav_drawer_cart')`
  - `Key('nav_drawer_profile')`
  - `Key('nav_drawer_about')`
  - `Key('nav_rail')` — persistent navigation on wide screens

- Example widget tests:
  - "drawer opens from AppBar and navigates to Profile"
  - "drawer closes after navigation"
  - "wide screen shows NavigationRail"

---

Notes:
- Prefer small commits: AppScaffold creation, screen migration, tests & final cleanup.
- Keep behavior consistent with existing UI style and keys used elsewhere in the repo.
