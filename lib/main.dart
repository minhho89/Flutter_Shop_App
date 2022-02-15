import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/providers/Auth.dart';
import 'package:shop_app_nojson/providers/Cart.dart';
import 'package:shop_app_nojson/providers/Products.dart';
import 'package:shop_app_nojson/routes.dart';
import 'package:shop_app_nojson/screens/auth_screen/auth_screen.dart';
import 'package:shop_app_nojson/screens/products_overview_screen/products_overview_screen.dart';

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
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: routes,
          home: auth.isAuth()
              ? const ProductsOverviewScreen()
              : const AuthScreen(),
        ),
      ),
    );
  }
}
