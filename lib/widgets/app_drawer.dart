import 'package:flutter/material.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_glass.dart';

import '../screens/orders_screen/order_screen.dart';
import '../screens/products_overview_screen/products_overview_screen.dart';
import '../screens/user_product_screen/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NeumorphicGlass(
        opacity: 0.8,
        blur: 8,
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
            ListTile(
              title: const Text('Orders history'),
              leading: const Icon(Icons.payment),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrderScreen.routeName),
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
      ),
    );
  }
}
