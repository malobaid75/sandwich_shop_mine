import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';

void main() {
  group('CheckoutScreen', () {
    testWidgets('renders order summary, items and total', (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      cart.add(sandwich, quantity: 2); // 2 * £7.00 = £14.00

      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('2x ${sandwich.name}'), findsOneWidget);
      // item price displayed next to the item
      expect(find.text('£14.00'), findsWidgets);
      // total row
      expect(find.text('£${cart.totalPrice.toStringAsFixed(2)}'), findsWidgets);
      expect(find.text('Confirm Payment'), findsOneWidget);
    });

    testWidgets('confirm payment processes and returns confirmation map', (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );
      cart.add(sandwich, quantity: 1); // 1 * £11.00 = £11.00

      Map? confirmationResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(cart: cart),
                    ),
                  );
                  confirmationResult = res as Map?;
                },
                child: const Text('Open Checkout'),
              ),
            );
          }),
        ),
      );

      // Open the checkout screen
      await tester.tap(find.text('Open Checkout'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Payment'), findsOneWidget);

      // Tap the confirm payment button
      await tester.tap(find.text('Confirm Payment'));
      // start the async work
      await tester.pump();
      // allow the fake delay in _processPayment to complete (2s) and navigation to return
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // After processing, the checkout screen should be popped and confirmationResult set
      expect(confirmationResult, isNotNull);
      expect(confirmationResult!['totalAmount'], closeTo(cart.totalPrice, 0.001));
      expect(confirmationResult!['itemCount'], cart.countOfItems);
      expect(confirmationResult!['orderId'], isA<String>());
    });
  });
}
