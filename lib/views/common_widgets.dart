import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/models/cart.dart';

/// Small logo widget used in app bars
class Logo extends StatelessWidget {
  final double height;
  const Logo({super.key, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}

/// Cart indicator that listens to Cart ChangeNotifier and shows count
class CartIndicator extends StatelessWidget {
  const CartIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart),
              const SizedBox(width: 4),
              Text('${cart.countOfItems}'),
            ],
          ),
        );
      },
    );
  }
}

/// Standardized AppBar used across the app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Logo(),
      title: Text(title, style: heading1),
      actions: [
        if (actions != null) ...actions!,
        const CartIndicator(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
