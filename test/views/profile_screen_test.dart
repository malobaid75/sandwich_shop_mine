import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  group('ProfileScreen', () {
    testWidgets('navigates from OrderScreen and saves valid profile', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

  // Tap the profile link (may be off-screen so scroll until visible)
  final profileLink = find.byKey(const ValueKey('profile_link'));
  expect(profileLink, findsOneWidget);
  await tester.ensureVisible(profileLink);
  await tester.pumpAndSettle();
  await tester.tap(profileLink);
  await tester.pumpAndSettle();

      // Ensure profile fields are present
      expect(find.byKey(const ValueKey('profile_name')), findsOneWidget);
      expect(find.byKey(const ValueKey('profile_email')), findsOneWidget);

      // Enter valid data
      await tester.enterText(find.byKey(const ValueKey('profile_name')), 'Alice');
      await tester.enterText(find.byKey(const ValueKey('profile_email')), 'alice@example.com');
      await tester.pumpAndSettle();

      // Tap save
      await tester.tap(find.byKey(const ValueKey('profile_save')));
      await tester.pump();

      // SnackBar should appear with exact text
      expect(find.text('Saved profile: Alice — alice@example.com'), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email and does not save', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

  // Navigate to profile (scroll if necessary)
  final profileLink2 = find.byKey(const ValueKey('profile_link'));
  await tester.ensureVisible(profileLink2);
  await tester.pumpAndSettle();
  await tester.tap(profileLink2);
  await tester.pumpAndSettle();

      // Enter name and invalid email
      await tester.enterText(find.byKey(const ValueKey('profile_name')), 'Bob');
      await tester.enterText(find.byKey(const ValueKey('profile_email')), 'not-an-email');
      await tester.pumpAndSettle();

      // Tap save
      await tester.tap(find.byKey(const ValueKey('profile_save')));
      await tester.pumpAndSettle();

      // Should show validation error text and not show SnackBar
      expect(find.text('Enter a valid email'), findsOneWidget);
      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
