import 'package:flutter/cupertino.dart';
import 'package:shop_app_nojson/screens/add_new_screen/add_new_screen.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/my_cart_screen.dart';
import 'package:shop_app_nojson/screens/orders_screen/order_screen.dart';
import 'package:shop_app_nojson/screens/products_overview_screen/products_overview_screen.dart';
import 'package:shop_app_nojson/screens/user_product_screen/user_product_screen.dart';

Map<String, WidgetBuilder> routes = {
  ProductsOverviewScreen.routeName: (context) => const ProductsOverviewScreen(),
  MyCartScreen.routeName: (context) => const MyCartScreen(),
  AddNewProductScreen.routeName: (context) => const AddNewProductScreen(),
  UserProductScreen.routeName: (context) => const UserProductScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
};
