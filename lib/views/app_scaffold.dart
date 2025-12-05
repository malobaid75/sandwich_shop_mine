import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const AppScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isWide = constraints.maxWidth >= 800;

      final Widget navList = ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Text('Sandwich Shop', style: heading1.copyWith(color: Colors.white)),
          ),
          ListTile(
            key: const ValueKey('drawer_home'),
            leading: const Icon(Icons.home),
            title: const Text('Order'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          ),
          ListTile(
            key: const ValueKey('drawer_profile'),
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            key: const ValueKey('drawer_about'),
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          ListTile(
            key: const ValueKey('drawer_checkout'),
            leading: const Icon(Icons.payment),
            title: const Text('Checkout'),
            onTap: () => Navigator.pushNamed(context, '/checkout'),
          ),
        ],
      );

      if (isWide) {
        // Permanent drawer on the left
        return Scaffold(
          appBar: AppBar(title: Text(title, style: heading1)),
          body: Row(
            children: [
              SizedBox(width: 260, child: Material(child: navList)),
              const VerticalDivider(width: 1),
              Expanded(child: child),
            ],
          ),
        );
      }

      // Normal scaffold with drawer
      return Scaffold(
        appBar: AppBar(title: Text(title, style: heading1)),
        drawer: Drawer(child: navList),
        body: child,
      );
    });
  }
}
