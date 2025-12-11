import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandwich_shop/views/settings_screen.dart';
import 'package:sandwich_shop/views/app_styles.dart';

void main() {
  group('SettingsScreen', () {
    testWidgets('loads initial font size and shows UI',
        (WidgetTester tester) async {
      // Provide mock prefs before the widget is created
      SharedPreferences.setMockInitialValues({'fontSize': 18.0});

      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

      // Initially shows loading indicator while settings are loaded
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Let async init complete
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Font Size'), findsOneWidget);
      expect(find.text('Current size: 18px'), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
      expect(find.text('Back to Order'), findsOneWidget);

      // Interact with the slider to change font size
      final Finder sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);

      // Tap slightly to the right of center to increase value
      final Offset sliderCenter = tester.getCenter(sliderFinder);
      await tester.tapAt(sliderCenter + const Offset(40, 0));
      await tester.pumpAndSettle();

      // After interaction font size should have changed from initial mock
      expect(AppStyles.baseFontSize, isNot(equals(18.0)));
    });
  });
}
