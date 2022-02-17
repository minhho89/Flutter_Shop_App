import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/Cart.dart';
import '../../../providers/Oders.dart';

class TotalRow extends StatefulWidget {
  const TotalRow({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalRow> createState() => _TotalRowState();
}

class _TotalRowState extends State<TotalRow> {
  bool _isLoading = false;

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
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        TextButton(
          onPressed: (cartData.calculateTotalAmount() <= 0 || _isLoading)
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Provider.of<Orders>(context, listen: false).addOrder(
                      cartData.items!.values.toList(),
                      cartData.calculateTotalAmount());
                  setState(() {
                    _isLoading = false;
                  });
                  cartData.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Order has been placed'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Okey',
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
                },
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('ORDER NOW'),
        ),
      ],
    );
  }
}
