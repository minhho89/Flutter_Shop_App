import 'package:flutter/material.dart';
import 'package:shop_app_nojson/screens/add_new_screen/add_new_screen.dart';

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
          const Divider(),
          ListTile(
            title: const Text('Manage products'),
            leading: const Icon(Icons.edit),
            onTap: () => Navigator.of(context).pushReplacementNamed(
                AddNewProductScreen.routeName), // TODO: change to manage page
          )
        ],
      ),
    );
  }
}
