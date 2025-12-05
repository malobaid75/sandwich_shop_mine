You are an expert Flutter developer LLM. Implement a responsive, app-wide navigation Drawer (and alternate wide-screen navigation) for the sandwich_shop_mine app. Read the repository before coding and adapt to existing APIs and styles. Make changes incremental and testable; update requirements.md to include this new task instead of creating a new requirements file.

Goal
- Add a Drawer accessible from all screens.
- Reduce redundant scaffold/drawer code by centralizing navigation in a shared AppScaffold.
- Make navigation responsive:
  - Narrow screens: show a Drawer opened from AppBar (hamburger).
  - Wide screens: show a persistent side rail or sidebar (NavigationRail or Drawer permanently visible).
- Add widget tests covering drawer navigation and responsive layout behavior.

General constraints
- Do not add heavy state management libraries; use setState or keep navigation stateless and rely on Navigator.
- All interactive widgets must have explicit Keys for tests:
  - Key('nav_drawer')
  - Key('nav_drawer_about')
  - Key('nav_drawer_profile')
  - Key('nav_drawer_cart')
  - Key('nav_drawer_order')
  - Key('nav_open_button') — AppBar leading button that opens drawer
  - For wide screen persistent nav, Key('nav_rail')
- Make Drawer items accessible (semantic labels).
- Update requirements.md: append a Drawer / Responsive Navigation subtask with user stories and acceptance criteria.

Primary tasks for the LLM to implement (small commits)
1) Inspect repository and find central scaffold helper (lib/views/app_scaffold.dart). If none exists, create AppScaffold to wrap Scaffold and include the Drawer/NavigationRail logic.

2) Implement AppScaffold
- Signature: AppScaffold({required String title, required Widget child, bool showBack = false})
- Behavior:
  - Detect screen width: use MediaQuery.of(context).size.width
  - If width < 700: show AppBar with a leading IconButton (hamburger) that opens Drawer (Drawer widget).
  - If width >= 700: replace AppBar leading with no drawer; render a NavigationRail or a permanent Drawer on the left and the content to the right.
- Drawer contents:
  - ListTile for Order (Navigator.pushReplacementNamed('/') or pop+push)
  - ListTile for Cart (route '/cart' or push)
  - ListTile for Profile (route '/profile')
  - ListTile for About (route '/about')
  - Use the Keys above and semantic labels.
- When tapped, each navigation action should close the drawer (if open) and navigate to the named route.
- Provide optional parameter to highlight current route (selected state).

3) Replace redundant Scaffold usage
- Update all screens to use AppScaffold (order_screen.dart, cart_screen.dart, profile_screen.dart, about_screen.dart, checkout_screen.dart). Do not change the visual layout of child content; simply wrap with AppScaffold to gain navigation.

4) Responsive behavior
- On wide screens (>=700px):
  - Show NavigationRail or persistent Drawer as part of the layout instead of an AppBar hamburger.
  - The child content should be horizontally next to the rail (Row: rail + Expanded(child)).
  - Ensure small-screen behavior unchanged.

5) Update requirements.md
- Append a new subtask "Navigation Drawer & Responsive Navigation" with description, user stories, and acceptance criteria (include Keys and tests to be added). Keep formatting consistent with existing requirements.md.

6) Tests
- Add widget tests under test/views:
  - test/views/navigation_drawer_test.dart
    - "drawer opens from AppBar and navigates to Profile": pump OrderScreen inside MaterialApp, ensure Drawer closed, tap Key('nav_open_button'), expect Drawer visible (find.byKey(Key('nav_drawer'))), tap profile item (Key('nav_drawer_profile')), expect pushed ProfileScreen (find.text('Profile / Sign in') or route).
    - "drawer closes after navigation": same flow but assert drawer is closed after navigation.
    - "wide screen shows NavigationRail": pump OrderScreen with a large width (wrap with MediaQuery with size width 1024), expect find.byKey(Key('nav_rail')) and no hamburger IconButton.
  - Use tester.tap/ensureVisible as needed and await animations.
- Use deterministic Keys when finding navigation items.

Acceptance criteria
- AppScaffold exists and is used by all app screens.
- On narrow screens:
  - AppBar shows an IconButton with Key('nav_open_button').
  - Tapping it opens a Drawer with Key('nav_drawer').
  - Drawer contains ListTiles with Keys for order/profile/cart/about that navigate to correct routes and close the drawer.
- On wide screens (>=700px):
  - No AppBar hamburger button; persistent NavigationRail or sidebar with Key('nav_rail') is visible and functional.
  - Selecting items updates route and highlights selection.
- requirements.md updated with the new task, user stories, acceptance criteria, and test plan.
- All new widget tests pass and flutter analyze reports no issues.

Files to change/create (exact suggested list)
- Modify: lib/views/app_scaffold.dart (or create if missing) — implement central scaffold with Drawer/NavigationRail
- Modify: lib/views/order_screen.dart — ensure uses AppScaffold (wrap content)
- Modify: lib/views/cart_screen.dart, lib/views/profile_screen.dart, lib/views/about_screen.dart, lib/views/checkout_screen.dart — wrap with AppScaffold
- Modify: lib/main.dart — ensure routes exist (/, /cart, /profile, /about, /checkout) and App uses them
- Create: test/views/navigation_drawer_test.dart — widget tests described above
- Modify: requirements.md — append the Drawer task (subtask) and tests to existing file

Implementation hints
- Use LayoutBuilder or MediaQuery to detect width.
- Drawer closing: Navigator.of(context).pop() before Navigator.pushNamed(...) or use pushReplacementNamed after pop.
- For tests, emulate different sizes:
  - final binding = TestWidgetsFlutterBinding.ensureInitialized(); await tester.pumpWidget(MediaQuery(data: MediaQueryData(size: Size(1024, 800)), child: app)); await tester.pumpAndSettle();
- Use semantics/tooltip for the hamburger IconButton to aid accessibility.

Deliverable
- Small, focused commits for:
  1) AppScaffold creation.
  2) Replace scaffolds on each screen to use AppScaffold.
  3) tests and requirements.md update.
- For each commit, provide the changed file list and a one-sentence commit message.

If you find any route names, file names, or existing scaffold helper that conflict, ask a clarifying question before editing. When ready, implement the AppScaffold first and create the navigation tests.
