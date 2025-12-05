# Cart Modification Feature Requirements

## 1. Feature Description and Purpose

The Cart Modification feature enables users of the Sandwich Shop Flutter app to manage the contents of their cart before checkout. Users can adjust the quantity of each sandwich or remove items. Editing sandwich details (such as bread type or size) is not supported on the cart page; users must add a new item from the order screen if they wish to change sandwich options. This feature aims to provide a flexible and user-friendly shopping experience, ensuring users can easily correct mistakes or change their order without starting over.

---

## 2. User Stories

```markdown
# Cart Modification Feature Requirements

## 1. Feature Description and Purpose

The Cart Modification feature enables users of the Sandwich Shop Flutter app to manage the contents of their cart before checkout. Users can adjust the quantity of each sandwich or remove items. Editing sandwich details (such as bread type or size) is not supported on the cart page; users must add a new item from the order screen if they wish to change sandwich options. This feature aims to provide a flexible and user-friendly shopping experience, ensuring users can easily correct mistakes or change their order without starting over.

---

## 2. User Stories

### 2.1. Adjust Quantity

- **As a user**, I want to increase or decrease the quantity of a sandwich in my cart, so I can order the exact number I want.
- **As a user**, I want the cart to automatically remove an item if I decrease its quantity below 1, so my cart never contains items with zero or negative quantity.

### 2.2. Remove Item

- **As a user**, I want to remove a sandwich from my cart with a single action, so I can quickly update my order if I change my mind.

### 2.3. Feedback and UI Responsiveness

- **As a user**, I want the cart and total price to update immediately when I make changes, so I always see an accurate summary of my order.
- **As a user**, I want to receive feedback (such as a snackbar) when I remove or update an item, so I know my action was successful.
- **As a user**, I want to see a clear message if my cart is empty, so I know I need to add items before checking out.

---

## 3. Acceptance Criteria

### 3.1. Quantity Adjustment

- [ ] Each cart item displays "+" and "–" buttons for quantity adjustment.
- [ ] Tapping "+" increases the quantity by 1.
- [ ] Tapping "–" decreases the quantity by 1.
- [ ] If the quantity is reduced below 1, the item is removed from the cart.
- [ ] The total price updates automatically and accurately.
- [ ] The UI updates immediately to reflect changes.

### 3.2. Remove Item

- [ ] Each cart item has a "Remove" button (e.g., trash icon).
- [ ] Tapping "Remove" deletes the item from the cart.
- [ ] The total price updates accordingly.
- [ ] A snackbar or similar feedback is shown when an item is removed.

### 3.3. General UI and Behavior

- [ ] All changes are reflected immediately in the UI.
- [ ] The cart's total price is always accurate.
- [ ] The cart handles empty states gracefully (e.g., displays a message if empty).
- [ ] The UI prevents negative quantities.
- [ ] User feedback is provided for all cart modification actions.

---

## 4. Subtasks

1. Implement "+" and "–" quantity adjustment buttons for each cart item.
2. Implement logic to remove an item if its quantity is reduced below 1.
3. Add a "Remove" button for each cart item.
4. Ensure the total price and UI update immediately after any change.
5. Provide user feedback (snackbar) for remove and update actions.
6. Handle empty cart states with a clear message.

---

## Profile / Sign-in Feature Requirements

### 1. Feature Description and Purpose

Add a lightweight Profile / Sign-in screen to the Sandwich Shop app. This screen is a local form only (no real authentication or persistence in this iteration). It allows users to enter and save basic profile details (full name and email) and will be reachable from the Order screen via a link. The purpose is to provide a simple, testable UI surface for future profile and authentication work.

---

### 2. User Stories

- **As a user**, I want to open a Profile / Sign-in screen from the Order screen, so I can provide my contact details for orders.
- **As a user**, I want to enter my full name and an email address, so the app can display and (in future) persist my profile.
- **As a user**, I want simple validation that prevents saving an empty name or an invalid email.
- **As a user**, I want feedback (a SnackBar) confirming my profile was saved.

---

### 3. Acceptance Criteria

- [ ] The app registers a route `/profile` that shows `ProfileScreen`.
- [ ] The Order screen includes a visible link (TextButton) at the bottom with key `profile_link` that navigates to `/profile`.
- [ ] `ProfileScreen` contains:
	- a `TextFormField` for full name with key `profile_name` and non-empty validation.
	- a `TextFormField` for email with key `profile_email` and a basic email regex validation.
	- an `ElevatedButton` labeled `Save` with key `profile_save`.
- [ ] On a successful save (valid name and email) a SnackBar appears with the exact text: `Saved profile: <name> — <email>`.
- [ ] Invalid input prevents saving and shows appropriate validation error text.
- [ ] All interactive widgets have keys as specified above to support deterministic widget tests.

---

### 4. Subtasks

1. Create `lib/views/profile_screen.dart` implementing the UI and validation described above. Use `setState` for local state. Do not add persistence or network calls.
2. Add an import and route in `lib/main.dart`: `'/profile': (context) => const ProfileScreen()`.
3. Add a `TextButton` with key `profile_link` at the bottom of `OrderScreen` that calls `Navigator.pushNamed(context, '/profile')`.
4. Add widget tests:
	 - `test/views/profile_screen_test.dart` — verify form validation and SnackBar on save.
	 - Optional: `test/views/profile_navigation_test.dart` — verify the named route exists and navigation works.
5. Run `flutter analyze` and `flutter test` and fix any issues.

---

### 5. Suggested AI prompt (to place in `prompt.md` or use locally)

````markdown
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
````

---

### 6. Notes / verification

- This `Profile / Sign-in` section was appended to the existing Cart Modification requirements to keep all pending feature specs in one place.
- The prompt above mirrors the content of `prompt.md` (if you want a canonical single source, we can consolidate both files to point to the same text).

```