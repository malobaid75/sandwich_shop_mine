import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Cart model', () {
    test('adding items merges identical sandwiches and increases quantity', () {
      final cart = Cart();

      final s1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );

      cart.add(s1);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 1);

      // Add same sandwich again
      cart.add(s1, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
    });

    test('remove decreases quantity and removes when zero', () {
      final cart = Cart();
      final s = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      cart.add(s, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 2);

      cart.remove(s);
      expect(cart.items.first.quantity, 1);

      cart.remove(s);
      expect(cart.items.length, 0);
    });

    test('total price sums items with correct pricing', () {
      final cart = Cart();

      final sixInch = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );

      final footlong = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      // 3 * 7 = 21
      cart.add(sixInch, quantity: 3);
      // 2 * 11 = 22
      cart.add(footlong, quantity: 2);

      expect(cart.totalQuantity, 5);
      expect(cart.totalPrice(), 43.0);
      expect(cart.formattedTotal(), '£43.00');
    });

    test('clear removes all items', () {
      final cart = Cart();
      final s = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );
      cart.add(s, quantity: 2);
      expect(cart.items.isNotEmpty, true);
      cart.clear();
      expect(cart.items.isEmpty, true);
    });
  });
}
