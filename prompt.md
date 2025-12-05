You are an expert Flutter developer LLM. Implement a lightweight Profile / Sign-in screen feature for the sandwich_shop_mine app. Read the repository before coding and adapt to existing APIs and style. Do not implement real authentication or persistence — the screen is only a local form for now.

Goal
- Add a Profile / Sign-in screen and a link to it from the Order screen.
- Keep implementation minimal, testable, and consistent with the existing app (use setState, no new state libs).
- Provide Keys for every interactive widget to make UI tests deterministic.

Required behavior
- New screen: ProfileScreen (route: '/profile').
  - UI: form with "Full name" and "Email" TextFormFields and a "Save" button.
  - Validation: name non-empty, email basic regex. On valid Save show a SnackBar: "Saved profile: <name> — <email>".
  - Keys:
    - profile_name (TextFormField)
    - profile_email (TextFormField)
    - profile_save (ElevatedButton)
- Add navigation:
  - Add import and route in lib/main.dart:
    - import 'package:sandwich_shop/views/profile_screen.dart';
    - routes['/profile'] => ProfileScreen()
  - Add a link on the Order screen (bottom), a TextButton with Key('profile_link') that Navigator.pushNamed('/profile').
- Tests:
  - Add widget test test/views/profile_screen_test.dart:
    - Test name: "profile screen form validation and save"
      - Pump OrderScreen, tap profile link, expect ProfileScreen visible.
      - Enter valid name/email, tap Save, expect SnackBar with saved message.
      - Enter invalid email, expect validation error text and no SnackBar.
  - Add widget test test/views/profile_navigation_test.dart (optional):
    - Ensure route '/profile' is registered and navigation works.
- Misc:
  - Use keys provided above.
  - No data persistence or network calls.
  - Keep UI accessible (labels, buttons).
  - Run flutter analyze and flutter test.

Files to change / create (exact paths)
- Create: lib/views/profile_screen.dart
- Modify: lib/main.dart (add import and route)
- Modify: lib/views/order_screen.dart (add TextButton with Key('profile_link') near bottom)
- Create tests: test/views/profile_screen_test.dart (and optional navigation test)

Example ProfileScreen skeleton (for guidance only — adapt style to existing app)
- show Scaffold, AppBar(title: 'Profile / Sign in')
- Form with two TextFormField + ElevatedButton as described above
- Show SnackBar on successful save

Acceptance criteria
- Profile screen exists and can be opened from Order screen via the profile link.
- Valid data shows SnackBar with correct message.
- Invalid data shows form validation errors and prevents save.
- All interactive widgets have Keys as specified.
- flutter analyze reports no issues and widget tests pass.

Execution notes for the LLM you call
1. Inspect the repo to adopt file structure / styles.
2. Implement minimal code, add Keys, add tests.
3. Run `flutter analyze` and `flutter test` locally (or report issues).
4. Return a short summary of changed files and the test results.

If any repo API or naming conflicts exist, ask a clarifying question before editing.