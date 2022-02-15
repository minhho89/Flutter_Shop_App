import 'package:flutter/material.dart';
import 'package:shop_app_nojson/screens/my_cart_screen/my_cart_screen.dart';

class Badge extends StatelessWidget {
  Badge({
    Key? key,
    required this.value,
  }) : super(key: key);

  int value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(MyCartScreen.routeName),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.shopping_cart,
            size: 36,
          ),
          Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
                constraints: const BoxConstraints(
                  minHeight: 16,
                  minWidth: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )),
        ],
      ),
    );
  }
}
