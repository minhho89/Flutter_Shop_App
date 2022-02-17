import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth.dart';
import '../providers/Cart.dart';
import '../providers/Product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context);
    Cart cart = Provider.of<Cart>(context);
    final auth = Provider.of<Auth>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
                color: Theme.of(context).colorScheme.secondary,
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () =>
                    product.toggleFavoriteStatus(auth.token!, auth.userId!)),
          ),
          subtitle: Text(product.title),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Item added'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => cart.removeAddedItem(product.id),
                  )));
            },
          ),
        ),
        child: Image.network(product.imageUrl),
      ),
    );
  }
}
