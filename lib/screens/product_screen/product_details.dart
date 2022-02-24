import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/providers/Products.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/product_details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: BackButton(
                  color: Theme.of(context).primaryColor,
                ),
                backgroundColor: kBackgroundColor,
                expandedHeight: MediaQuery.of(context).size.height * 1 / 3,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: loadedProduct.id,
                    child: Image.network(
                      loadedProduct.imageUrl,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                NeumorphicCard(
                  borderRadius: BorderRadius.circular(13),
                  shadowBlur: 13,
                  backgroundColor: kBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          loadedProduct.title,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          '\$${loadedProduct.price}',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .fontSize),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        loadedProduct.description,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize),
                      ),
                    ),
                  ),
                )
              ]))
            ],
          ),
        ));
  }
}
