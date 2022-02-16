import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/Products.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const routeName = '/user_product';

  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products Management'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.items.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(products.items[index].title),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(products.items[index].imageUrl),
            ),
            subtitle:
                Text('\$${products.items[index].price.toStringAsFixed(2)}'),
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
    );
  }
}
