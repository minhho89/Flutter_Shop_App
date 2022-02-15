import 'package:flutter/material.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/components/cart_item.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/components/total_row.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Card(
            child: TotalRow(),
            elevation: 3,
          ),
          CartItemWidget(),
        ],
      ),
    );
  }
}
