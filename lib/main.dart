import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop_app_nojson/consts/routes.dart';
import 'package:shop_app_nojson/providers/Auth.dart';
import 'package:shop_app_nojson/providers/Cart.dart';
import 'package:shop_app_nojson/providers/Oders.dart';
import 'package:shop_app_nojson/providers/Products.dart';
import 'package:shop_app_nojson/screens/product_screen/product_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> providers = [
      ChangeNotifierProvider.value(value: Products()),
      ChangeNotifierProvider.value(value: Cart()),
      ChangeNotifierProvider.value(value: Auth()),
      ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(),
          update: (ctx, auth, previousProducts) {
            print('Auth token = ${auth.token}');
            return Products.auth(auth.userId, auth.token,
                previousProducts == null ? [] : previousProducts.items);
          }),
      ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, previousOrders) => Orders.name(auth.userId,
              auth.token, previousOrders == null ? [] : previousOrders.orders))
    ];

    return MultiProvider(
      providers: [...providers],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tan Tien shop app',
          theme: buildThemeData(),
          routes: routes,
          // home: auth.isAuth()
          //     ? const ProductsOverviewScreen()
          //     : FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapShot) =>
          //             authResultSnapShot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? const Center(child: CircularProgressIndicator())
          //                 : const AuthScreen()),
          home: const ProductDetailsScreen(),
        ),
      ),
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
      fontFamily: 'Lato',
      primarySwatch: Colors.purple,
      colorScheme: const ColorScheme(
        secondary: Colors.deepOrange,
        brightness: Brightness.light,
        onError: Colors.redAccent,
        onSecondary: Colors.orange,
        onBackground: Colors.blueGrey,
        error: Colors.red,
        background: Colors.grey,
        onSurface: Colors.yellowAccent,
        surface: Colors.yellow,
        primary: Colors.purple,
        onPrimary: Colors.white,
      ),
    );
  }
}
