import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/Cart.dart';

class TotalRow extends StatelessWidget {
  const TotalRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cartData = Provider.of<Cart>(context);

    return Row(
      children: [
        const Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 5.0), child: Text('Total')),
        ),
        Chip(
          label: Text(
            '\$${cartData.calculateTotalAmount().toStringAsFixed(2)}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Order Now'),
        ),
      ],
    );
  }
}
