import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name getter returns expected human-readable names', () {
      final expected = {
        SandwichType.veggieDelight: 'Veggie Delight',
        SandwichType.chickenTeriyaki: 'Chicken Teriyaki',
        SandwichType.tunaMelt: 'Tuna Melt',
        SandwichType.meatballMarinara: 'Meatball Marinara',
      };

      for (final entry in expected.entries) {
        final sandwich = Sandwich(
          type: entry.key,
          isFootlong: true,
          breadType: BreadType.white,
        );
        expect(sandwich.name, entry.value);
      }
    });

    test('image path includes enum name and size suffix', () {
      final footlong = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      final sixInch = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      expect(footlong.image, 'assets/images/${SandwichType.tunaMelt.name}_footlong.png');
      expect(sixInch.image, 'assets/images/${SandwichType.tunaMelt.name}_six_inch.png');
    });
  });
}
