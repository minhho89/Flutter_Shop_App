import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/routes.dart';
import 'package:shop_app_nojson/providers/Auth.dart';
import 'package:shop_app_nojson/providers/Cart.dart';
import 'package:shop_app_nojson/providers/Products.dart';
import 'package:shop_app_nojson/screens/user_product_screen/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products(),
            update: (ctx, auth, previousProducts) {
              print('Auth token = ${auth.token}');
              return Products.auth(auth.userId, auth.token,
                  previousProducts == null ? [] : previousProducts.items);
            })
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: routes,
          // home: auth.isAuth()
          //     ? const ProductsOverviewScreen()
          //     : const AuthScreen(),
          home: const UserProductScreen(),
        ),
      ),
    );
  }
}
