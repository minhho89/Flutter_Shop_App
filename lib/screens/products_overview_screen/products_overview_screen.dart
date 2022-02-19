import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/providers/Cart.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/my_cart_screen.dart';
import 'package:shop_app_nojson/widgets/app_appbar,.dart';
import 'package:shop_app_nojson/widgets/app_drawer.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_button.dart';

import '../../providers/Products.dart';
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
      backgroundColor: kBackgroundColor,
      appBar: CusTomAppBar(
        key: scaffoldKey,
        context: context,
        actions: [
          buildPopupMenuButton(),
          buildConsumerCart(context),
        ],
      ),
      // appBar: AppBar(
      //   toolbarHeight: MediaQuery.of(context).size.height * 1 / 10,
      //   leadingWidth: 75,
      //   elevation: 0,
      //   backgroundColor: kBackgroundColor,
      //   title: Text(
      //     'Products',
      //     style: TextStyle(color: Theme.of(context).primaryColor),
      //   ),
      //   leading: buildLeadingButton(),
      //   actions: [
      //     buildPopupMenuButton(),
      //     buildConsumerCart(context),
      //   ],
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Body(
              showFav: _showOnlyFavorites,
            ),
      drawer: buildDrawer(context),
    );
  }

  Consumer<Cart> buildConsumerCart(BuildContext context) {
    return Consumer<Cart>(
      builder: (_, cart, child) => Padding(
        padding: const EdgeInsets.all(15),
        child: NeumorphicButton(
          width: 40,
          height: 40,
          borderRadius: BorderRadius.circular(3),
          initialBlurRadius: 5,
          tappedBlurRadius: 3,
          onPressed: () =>
              Navigator.of(context).pushNamed(MyCartScreen.routeName),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Badge(
              elevation: 0,
              badgeColor: Theme.of(context).primaryColor,
              position: BadgePosition.topEnd(),
              badgeContent: Text(cart.quantityCount.toString()),
              child: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Theme buildDrawer(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: const AppDrawer(),
    );
  }

  Padding buildPopupMenuButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
      child: NeumorphicButton(
        onPressed: () {},
        height: 40,
        initialBlurRadius: 5,
        tappedBlurRadius: 3,
        borderRadius: BorderRadius.circular(8.0),
        child: PopupMenuButton(
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
      ),
    );
  }

  Padding buildLeadingButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: NeumorphicButton(
        initialBlurRadius: 5,
        tappedBlurRadius: 3,
        borderRadius: BorderRadius.circular(8.0),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        child: const Icon(
          Icons.menu,
        ),
      ),
    );
  }
}
