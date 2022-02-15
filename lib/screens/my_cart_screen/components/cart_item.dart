import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/Cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cartData = Provider.of<Cart>(context);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cartData.itemCount,
      itemBuilder: (context, index) => Card(
        child: Dismissible(
          key: ValueKey(cartData.items!.values.toList()[index].id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<Cart>(context, listen: false)
                .removeItem(cartData.items!.keys.toList()[index]);
          },
          background: Container(
            color: Theme.of(context).errorColor,
            child: const Icon(Icons.delete, color: Colors.white),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 10),
          ),
          child: ListTile(
            title: Text(cartData.items!.values.toList()[index].title),
            trailing:
                Text('${cartData.items!.values.toList()[index].quantity}x'),
            subtitle: Text(
                'Unit price: \$${cartData.items!.values.toList()[index].price}'),
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: FittedBox(
                  child: Text(
                      '\$${cartData.items!.values.toList()[index].totalAmount.toStringAsFixed(2)}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
