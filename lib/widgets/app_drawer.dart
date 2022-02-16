import 'package:flutter/material.dart';
import 'package:shop_app_nojson/screens/products_overview_screen/products_overview_screen.dart';

import '../screens/user_product_screen/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello!'),
          ),
          ListTile(
            title: const Text('Shop'),
            leading: const Icon(Icons.shop),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductsOverviewScreen.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('Manage products'),
            leading: const Icon(Icons.edit),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductScreen.routeName),
          ),
        ],
      ),
    );
  }
}
