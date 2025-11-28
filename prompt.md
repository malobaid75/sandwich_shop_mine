You are an expert Flutter developer LLM. Implement cart item modification features for the sandwich_shop_mine app. Read the repository before coding and adapt to existing APIs (Cart model, Sandwich model, PricingRepository). Provide small, testable commits and include unit + widget tests.

Project facts (inspect to confirm)
- Sandwich model: lib/models/sandwich.dart (has type, size, bread, toasted).
- Cart model: lib/models/cart.dart (has add/remove/clear; extend if needed).
- PricingRepository: lib/repositories/pricing_repository.dart (single source of truth for prices; exposes a price calculation method — inspect actual method name and use it).
- Screens: lib/views/order_screen.dart and lib/views/cart_screen.dart

General requirements
- Keep UX simple and accessible.
- All interactive widgets must have explicit Keys for reliable tests (see examples below).
- Use PricingRepository for all price calculations; the sandwich type or bread do not affect price.
- Immediate UI updates on actions (optimistic). Use SnackBar with UNDO for removals/clear.
- Follow existing code style and state management approach (use setState if screen is stateful; do not introduce heavy state libs unless the repo already uses one).
- Write tests: unit tests for Cart behavior and widget tests for UI interactions.

Features to implement (clear behavior + what to assert)

1) Increment / Decrement item quantity
- UI:
  - Per cart item show: [ - ] [ quantity ] [ + ]
  - Keys: Key('cart_item_{index}_decrement'), Key('cart_item_{index}_quantity'), Key('cart_item_{index}_increment')
- Behavior:
  - "+" increases quantity by 1 up to a sensible max (use existing maxQuantity if available; otherwise 99).
  - "-" decreases quantity by 1; if result is 0, remove the item (or optionally disallow decrement below 1 — choose one and document).
  - Update Cart model with Cart.updateQuantity(itemId, newQuantity) (or implement equivalent).
  - Recompute total price via PricingRepository and update cart summary immediately.
- Tests:
  - Unit: test/models/cart_test.dart — add item, update quantity, assert Cart.totalQuantity and Cart.totalPrice().
  - Widget: test/views/cart_widget_test.dart — pump CartScreen, add a known item, tap increment (find.byKey), expect summary text and per-item quantity text updated.

2) Remove item (single)
- UI:
  - Per item remove button: Key('cart_item_{index}_remove'). Optionally swipe-to-dismiss.
- Behavior:
  - Tapping Remove deletes item from cart.
  - Show SnackBar "Removed <name> — UNDO" that when tapped restores the removed item to previous quantity.
  - Immediately update cart summary.
- Tests:
  - Unit: removing updates totals.
  - Widget: remove item, expect item absent and summary updated; tap UNDO in SnackBar, expect item restored and summary restored.

3) Edit item options (size, bread, toasted)
- UI:
  - Per item Edit button: Key('cart_item_{index}_edit') opens modal/dialog.
  - Modal contains size switch (six-inch/footlong) Key('edit_size_switch'), bread dropdown Key('edit_bread_dropdown'), toasted switch Key('edit_toasted_switch'), Save button Key('edit_save').
- Behavior:
  - Saving updates the cart item. If resulting item matches another item in cart, merge quantities.
  - Recalculate price via PricingRepository and update summary.
- Tests:
  - Widget: open edit modal, change size, save, verify item price and cart summary changed accordingly.

4) Clear cart (bulk)
- UI:
  - Clear button on cart screen: Key('cart_clear').
  - Confirm dialog before clearing.
- Behavior:
  - Clearing empties cart; show SnackBar with UNDO to restore previous content.
  - Summary updates to "Cart: 0 item(s) — Total: £0.00".
- Tests:
  - Widget: add items, tap Clear, confirm, expect empty cart and summary; test UNDO restores items.

5) Permanent cart summary (OrderScreen)
- UI:
  - On OrderScreen show a permanent summary row: Key('cart_summary') with text "Cart: X item(s) — Total: £Y.YY".
- Behavior:
  - Updates on any cart change (add, remove, edit, quantity change).
- Tests:
  - Widget test: initial summary "Cart: 0 item(s) — Total: £0.00"; after Add to Cart expect updated count and price.

Edge cases & constraints
- Prevent negative quantities. Either remove item at 0 (and offer UNDO) or prevent decrement below 1 — pick and document.
- Enforce a logical max quantity (e.g., OrderScreen provided maxQuantity); disable increment at max and surface clear UI affordance.
- Display prices in GBP with two decimal places and "£" symbol (use existing formatting utilities or implement formattedTotal()).
- Inspect existing Cart and PricingRepository APIs; adapt method names. If method names differ, wrap adapter functions inside Cart model.

File changes to make (suggested)
- lib/views/cart_screen.dart — list items with increment/decrement, edit, remove, clear; SnackBar undo.
- lib/views/order_screen.dart — ensure Cart instance is shared or pass via constructor; add Key('cart_summary') UI.
- lib/models/cart.dart — ensure methods: addItem(...), updateQuantity(itemId, newQuantity), removeItem(itemId), clear(), totalQuantity, totalPrice(), formattedTotal(); use PricingRepository for price calculation.
- lib/repositories/pricing_repository.dart — no change beyond usage (confirm API).
- test/models/cart_test.dart — unit tests for add/update/remove/clear/price.
- test/views/cart_widget_test.dart — widget tests for UI flows using find.byKey.

Example test assertions (exact text must match your UI)
- Initial: expect(find.text('Cart: 0 item(s) — Total: £0.00'), findsOneWidget)
- After adding one footlong (default): expect(find.text('Cart: 1 item(s) — Total: £11.00'), findsOneWidget)
- After increment: expect(find.text('Cart: 2 item(s) — Total: £22.00'), findsOneWidget)
- After remove: expect item tile not found and summary updated accordingly
- After UNDO: expect item tile found and summary restored

Deliverables for each feature
1. Code changes (files + short description).
2. Unit tests added/updated under test/models.
3. Widget tests under test/views using Keys.
4. Short README note describing new interactions (optional).
5. Short commit messages (one feature per commit).

Development hints for the LLM you call
- Read existing Cart and PricingRepository APIs first; do not assume exact method names — adapt and/or add small adapter methods in Cart.
- Favor simple setState-based updates on screens unless a different pattern is already used.
- Ensure Keys are present and deterministic to make tests stable.
- Use SnackBarAction for UNDO and preserve removed item data to restore on undo.
- Keep UI minimal and consistent with existing app styles.

Return format expected from you (LLM):
- A step-by-step implementation plan (files to change).
- For each changed file, a minimal code patch or the new file.
- Tests to add, with exact test names and assertions.
- Any assumptions made about existing APIs (list them).
- If you cannot find an API method, ask a clarifying question before editing code.