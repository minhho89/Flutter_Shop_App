import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/screens/add_new_screen/add_new_screen.dart';
import 'package:shop_app_nojson/widgets/app_drawer.dart';

import '../../providers/Products.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const routeName = '/user_product';

  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Management'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddNewProductScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: const AppDrawer(),
      ),
      body: FutureBuilder(
        future: products.fetchAndSetProducts(true),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => products.fetchAndSetProducts(true),
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
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(AddNewProductScreen.routeName,
                                        arguments: products.items[index].id),
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
