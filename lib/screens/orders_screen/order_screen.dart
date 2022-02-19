import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/providers/Oders.dart';
import 'package:shop_app_nojson/screens/orders_screen/components/order_item.dart'
    as ord;
import 'package:shop_app_nojson/widgets/app_appbar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static String routeName = '/orders';
  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CusTomAppBar(
        context: context,
        titleText: 'My Orders',
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder(
        future: _refreshOrders(context),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              print(dataSnapshot.error.toString());
              return const Center(
                child: Text('Some error occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) =>
                      ord.OrderItem(order: orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
