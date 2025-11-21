import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

/// A single entry in the cart representing a sandwich and its quantity.
class CartItem {
	final Sandwich sandwich;
	int quantity;

	CartItem({required this.sandwich, this.quantity = 1});

	/// Two cart items are considered the same if they refer to the same
	/// sandwich type, size and bread type.
	bool matches(Sandwich other) {
		return sandwich.type == other.type &&
				sandwich.isFootlong == other.isFootlong &&
				sandwich.breadType == other.breadType;
	}
}

/// Simple cart model that holds multiple [CartItem] entries and computes
/// totals using [PricingRepository].
class Cart {
	final PricingRepository _pricingRepository;
	final List<CartItem> _items = [];

	Cart({PricingRepository? pricingRepository}) : _pricingRepository = pricingRepository ?? PricingRepository();

	/// Read-only view of items in the cart.
	List<CartItem> get items => List.unmodifiable(_items);

	/// Total number of individual sandwiches in the cart.
	int get totalQuantity => _items.fold(0, (p, e) => p + e.quantity);

	/// Total price across all items (uses PricingRepository for per-item
	/// calculations).
	double totalPrice() {
		double total = 0.0;
			for (final item in _items) {
				total += _pricingRepository.calculatePrice(quantity: item.quantity, isFootlong: item.sandwich.isFootlong);
			}
		return total;
	}

	/// Human-friendly formatted total (pound symbol, two decimals).
	String formattedTotal() => '£${totalPrice().toStringAsFixed(2)}';

	/// Add a sandwich to the cart. If an identical sandwich exists, increment
	/// its quantity.
	void add(Sandwich sandwich, {int quantity = 1}) {
		if (quantity <= 0) return;
		final index = _items.indexWhere((it) => it.matches(sandwich));
		if (index >= 0) {
			_items[index].quantity += quantity;
		} else {
			_items.add(CartItem(sandwich: sandwich, quantity: quantity));
		}
	}

	/// Remove a certain quantity of the sandwich. If quantity reduces to 0 or
	/// below, the item is removed from the cart.
	void remove(Sandwich sandwich, {int quantity = 1}) {
		final index = _items.indexWhere((it) => it.matches(sandwich));
		if (index < 0) return;
		final item = _items[index];
		item.quantity -= quantity;
		if (item.quantity <= 0) {
			_items.removeAt(index);
		}
	}

	/// Set the exact quantity for a sandwich. If quantity <= 0 the item is removed.
	void updateQuantity(Sandwich sandwich, int quantity) {
		final index = _items.indexWhere((it) => it.matches(sandwich));
		if (index < 0) {
			if (quantity > 0) {
				_items.add(CartItem(sandwich: sandwich, quantity: quantity));
			}
			return;
		}
		if (quantity <= 0) {
			_items.removeAt(index);
		} else {
			_items[index].quantity = quantity;
		}
	}

	/// Remove all items from the cart.
	void clear() => _items.clear();
}

