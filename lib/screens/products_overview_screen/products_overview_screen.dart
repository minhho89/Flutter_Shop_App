import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/providers/Cart.dart';
import 'package:shop_app_nojson/widgets/app_drawer.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_button.dart';

import '../../providers/Products.dart';
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
  bool _isLoading = false;
  bool _isInit = true;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        print('fetch done');
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Products',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        leading: NeumorphicButton(
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          child: const Icon(Icons.menu),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.red,
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Body(
              showFav: _showOnlyFavorites,
            ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: const AppDrawer(),
      ),
    );
  }
}
