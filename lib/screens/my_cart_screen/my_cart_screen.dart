import 'package:flutter/material.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/widgets/app_appbar.dart';

import 'components/body.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  static String routeName = '/my_cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: buildDrawer(context),
      appBar: CusTomAppBar(
        titleText: 'My Cart',
        context: context,
      ),
      body: const Body(),
    );
  }
}
