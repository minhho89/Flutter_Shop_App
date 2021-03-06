import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/components/cart_item.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/components/total_row.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_card.dart';

import '../../../providers/Oders.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              children: [
                NeumorphicCard(
                  backgroundColor: kBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  shadowBlur: 13,
                  child: TotalRow(),
                ),
                CartItemWidget(),
              ],
            ),
          );
        });
  }
}
