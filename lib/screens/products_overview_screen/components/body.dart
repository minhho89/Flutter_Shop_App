import 'package:flutter/material.dart';

import '../../../widgets/products_grid.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.showFav,
  }) : super(key: key);

  final bool showFav;

  @override
  Widget build(BuildContext context) {
    return ProductsGrid(
      showFav: showFav,
    );
  }
}
