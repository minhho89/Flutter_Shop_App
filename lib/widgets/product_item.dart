import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/screens/product_screen/product_details.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_button.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_glass.dart';

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

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          NeumorphicButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(ProductDetailsScreen.routeName),
            borderRadius: kProductCartBorderRadius,
            child: ClipRRect(
              borderRadius: kProductCartBorderRadius,
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: kBackgroundColor,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      )
                    ],
                  ),
                ),
                child: Hero(
                  tag: 'p_image',
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 3,
            child: Consumer<Product>(
              builder: (context, product, child) => NeumorphicGlass(
                blur: 20,
                opacity: 0.5,
                borderRadius: BorderRadius.circular(30),
                child: IconButton(
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                    onPressed: () => product.toggleFavoriteStatus(
                        auth.token!, auth.userId!)),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 3,
            child: NeumorphicGlass(
              blur: 20,
              opacity: 0.5,
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Item added',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () => cart.removeAddedItem(product.id),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
