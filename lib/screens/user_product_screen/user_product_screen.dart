import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/widgets/app_drawer.dart';

import '../../providers/Products.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const routeName = '/user_product';

  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context, listen: false);
    products.token = debugUserToken;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Management'),
        actions: [
          IconButton(
            onPressed: () => products.fetchAndSetProducts(),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: products.fetchAndSetProducts(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => products.fetchAndSetProducts(),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => ListView.builder(
                        itemCount: products.items.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(products.items[index].title),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(products.items[index].imageUrl),
                            ),
                            subtitle: Text(
                                '\$${products.items[index].price.toStringAsFixed(2)}'),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
