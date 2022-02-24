import 'package:flutter/material.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/product_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            NeumorphicCard(
              borderRadius: BorderRadius.circular(13),
              shadowBlur: 13,
              backgroundColor: kBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: 'p_image',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                              'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      '\$34.44',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline4!.fontSize),
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
                    'Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
