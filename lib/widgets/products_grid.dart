import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_button.dart';

import '../providers/Products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
    required this.showFav,
  }) : super(key: key);

  final bool showFav;

  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favoriteItems : productsData.items;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 3),
        itemBuilder: (context, i) => NeumorphicButton(
          borderRadius: kProductCartBorderRadius,
          onPressed: () {},
          child: ChangeNotifierProvider.value(
            value: products[i],
            child: const ProductItem(),
          ),
        ),
      ),
    );
  }
}
