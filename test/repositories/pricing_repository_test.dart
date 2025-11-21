import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    test('calculates six-inch price correctly', () {
      final repo = PricingRepository(); // defaults: 7.0 / 11.0
      final total = repo.totalPrice(quantity: 3, isFootlong: false);
      expect(total, 21.0);
      expect(repo.formattedTotal(quantity: 3, isFootlong: false), '£21.00');
    });

    test('calculates footlong price correctly', () {
      final repo = PricingRepository();
      final total = repo.totalPrice(quantity: 2, isFootlong: true);
      expect(total, 22.0);
      expect(repo.formattedTotal(quantity: 2, isFootlong: true), '£22.00');
    });

    test('zero quantity returns zero price', () {
      final repo = PricingRepository();
      expect(repo.totalPrice(quantity: 0, isFootlong: true), 0.0);
      expect(repo.formattedTotal(quantity: 0, isFootlong: false), '£0.00');
    });

    test('custom prices are supported via constructor', () {
      final repo = PricingRepository(sixInchPrice: 5.5, footlongPrice: 9.5);
      expect(repo.totalPrice(quantity: 2, isFootlong: false), 11.0);
      expect(repo.formattedTotal(quantity: 1, isFootlong: true), '£9.50');
    });
  });
}
