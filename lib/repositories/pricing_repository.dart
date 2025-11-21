class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  PricingRepository({this.sixInchPrice = 7.0, this.footlongPrice = 11.0});

  /// Returns the total price (as a double) for the given quantity and size.
  double totalPrice({required int quantity, required bool isFootlong}) {
    final pricePer = isFootlong ? footlongPrice : sixInchPrice;
    return pricePer * quantity;
  }

  /// Returns a formatted price string prefixed with the pound symbol.
  String formattedTotal({required int quantity, required bool isFootlong}) {
    final total = totalPrice(quantity: quantity, isFootlong: isFootlong);
    return '£${total.toStringAsFixed(2)}';
  }
}
