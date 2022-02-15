import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/providers/Cart.dart';

import '../../widgets/badge.dart';
import 'components/body.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  static String routeName = '/products_overview';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                  child: Text('Show Favorite'), value: FilterOptions.favorites),
              const PopupMenuItem(
                  child: Text('Show All'), value: FilterOptions.all),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.quantityCount,
            ),
          ),
        ],
      ),
      body: Body(
        showFav: _showOnlyFavorites,
      ),
      drawer: const AppDrawer(),
    );
  }
}

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
          const ListTile(
            title: Text('Add new product'),
            leading: Icon(Icons.add_business_outlined),
          )
        ],
      ),
    );
  }
}
