import 'package:flutter/material.dart';
import 'package:shop_app_nojson/screens/add_new_screen/components/body.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  static const String routeName = '/add_new_product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
      ),
      body: Body(),
    );
  }
}
