import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/cart_screen.dart';

void main() {
  group('CartScreen quantity buttons', () {
    testWidgets('quantity increments update total', (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: cart,
            child: const CartScreen(),
          ),
        ),
      );

      // Initial assertions
      expect(find.text('Qty: 1'), findsOneWidget);
      expect(find.text('Total: £7.00'), findsOneWidget);

      // Tap increment
      final incrementKey = ValueKey('cart_increment_${sandwich.name}_${sandwich.isFootlong}_${sandwich.breadType.name}');
      await tester.tap(find.byKey(incrementKey));
      await tester.pumpAndSettle();

      // Quantity and total should update
      expect(find.text('Qty: 2'), findsOneWidget);
      expect(find.text('Total: £14.00'), findsOneWidget);
    });

    testWidgets('decrement removes item when quantity goes below 1 and updates total', (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: cart,
            child: const CartScreen(),
          ),
        ),
      );

      // Initial state: qty 2, total £14.00
      expect(find.text('Qty: 2'), findsOneWidget);
      expect(find.text('Total: £14.00'), findsOneWidget);

      final decrementKey = ValueKey('cart_decrement_${sandwich.name}_${sandwich.isFootlong}_${sandwich.breadType.name}');

      // Tap decrement once -> qty 1
      await tester.tap(find.byKey(decrementKey));
      await tester.pumpAndSettle();
      expect(find.text('Qty: 1'), findsOneWidget);
      expect(find.text('Total: £7.00'), findsOneWidget);

      // Tap decrement again -> item removed, qty text should be gone, total 0
      await tester.tap(find.byKey(decrementKey));
      await tester.pumpAndSettle();

      expect(find.textContaining('Qty:'), findsNothing);
      expect(find.text('Total: £0.00'), findsOneWidget);
    });
  });
}
