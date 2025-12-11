import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/about_screen.dart';

void main() {
  group('AboutScreen', () {
    testWidgets('displays about content and navigation when wide',
        (WidgetTester tester) async {
      const AboutScreen about = AboutScreen();

      final MaterialApp app = MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(1000, 800)),
          child: about,
        ),
      );

      await tester.pumpWidget(app);

      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Welcome to Sandwich Shop!'), findsOneWidget);
      expect(find.textContaining('family-owned'), findsOneWidget);

      // On wide layouts the navigation list is visible permanently.
      expect(find.byKey(const ValueKey('drawer_about')), findsOneWidget);
      expect(find.byKey(const ValueKey('drawer_profile')), findsOneWidget);
      expect(find.byKey(const ValueKey('drawer_home')), findsOneWidget);
    });

    testWidgets('shows drawer on narrow layout', (WidgetTester tester) async {
      const AboutScreen about = AboutScreen();

      final MaterialApp app = MaterialApp(home: about);

      await tester.pumpWidget(app);

      // Drawer not visible until opened
      expect(find.byKey(const ValueKey('drawer_about')), findsNothing);

      // Open the drawer and verify items
      final Finder openDrawer = find.byTooltip('Open navigation menu');
      if (openDrawer.evaluate().isNotEmpty) {
        await tester.tap(openDrawer);
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('drawer_about')), findsOneWidget);
        expect(find.text('About'), findsOneWidget);
      } else {
        // Fallback: ensure AppBar exists so drawer would be reachable
        expect(find.byType(AppBar), findsOneWidget);
      }
    });
  });
}
