import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/screens/auth_screen/auth_screen.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_glass.dart';

import '../providers/Auth.dart';
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
        opacity: 0.6,
        blur: 5,
        child: Column(
          children: [
            AppBar(
              backgroundColor: kBackgroundColor,
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
            const Divider(),
            ListTile(
                title: const Text('Sign out'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                  Provider.of<Auth>(context, listen: false).logout();
                })
          ],
        ),
      ),
    );
  }
}
