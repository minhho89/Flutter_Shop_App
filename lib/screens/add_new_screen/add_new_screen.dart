import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/widgets/app_appbar.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_button.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_card.dart';
import 'package:shop_app_nojson/widgets/neumorphics/neumorphic_text_input_field.dart';

import '../../providers/Product.dart';
import '../../providers/Products.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  static const String routeName = '/add_new_product';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _imageURLController = TextEditingController();
  bool _isLoading = false;
  Product _p = Product(
    id: '',
    title: '',
    price: 0.0,
    description: '',
    imageUrl: '',
  );
  var _isInit = true;
  var _initValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final String? productId =
          ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _p = Provider.of<Products>(context, listen: false).findById(productId);
        _initValue = {
          'title': _p.title,
          'description': _p.description,
          'price': _p.price.toString(),
          'imageUrl': _p.imageUrl,
        };
        // _imageUrlController.text = _p.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    bool isValid = _keyForm.currentState!.validate();

    if (!isValid) {
      return;
    }
    _keyForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    // add product
    try {
      await Provider.of<Products>(context, listen: false).addProduct(_p);
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occured!'),
          content: const Text('Something went wrong'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'))
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CusTomAppBar(
          context: context,
          titleText: 'Add new product',
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NeumorphicButton(
                borderRadius: BorderRadius.circular(10),
                onPressed: _saveForm,
                child: const Icon(Icons.save),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _keyForm,
                    child: ListView(
                      children: [
                        NeumorphicTextInputField(
                          borderRadius: BorderRadius.circular(8),
                          textFormField: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Title'),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                _p = Product(
                                  title: value ?? '',
                                  imageUrl: _p.imageUrl,
                                  description: _p.description,
                                  price: _p.price,
                                  id: _p.id,
                                  isFavorite: _p.isFavorite,
                                );
                              }),
                        ),
                        NeumorphicTextInputField(
                          textFormField: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Price'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                _p = Product(
                                  title: _p.title,
                                  imageUrl: _p.imageUrl,
                                  description: _p.description,
                                  price: double.parse(value ?? '0'),
                                  id: _p.id,
                                  isFavorite: _p.isFavorite,
                                );
                              }),
                        ),
                        NeumorphicTextInputField(
                          textFormField: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                label: Text('Decoration'),
                              ),
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                _p = Product(
                                  title: _p.title,
                                  imageUrl: _p.imageUrl,
                                  description: value ?? '',
                                  price: _p.price,
                                  id: _p.id,
                                  isFavorite: _p.isFavorite,
                                );
                              }),
                        ),
                        Row(
                          children: [
                            NeumorphicCard(
                              shadowBlur: 13,
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: kBackgroundColor,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: _imageURLController.text.isEmpty
                                    ? const Text('Enter Image URL')
                                    : Image.network(_imageURLController.text,
                                        fit: BoxFit.fill),
                              ),
                            ),
                            Expanded(
                              child: NeumorphicTextInputField(
                                textFormField: TextFormField(
                                    controller: _imageURLController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.url,
                                    decoration: const InputDecoration(
                                      label: Text('Image URL'),
                                      enabledBorder: UnderlineInputBorder(),
                                    ),
                                    onFieldSubmitted: (_) {
                                      setState(() {});
                                      _saveForm();
                                    },
                                    onSaved: (value) {
                                      _p = Product(
                                        title: _p.title,
                                        imageUrl: value ?? '',
                                        description: _p.description,
                                        price: _p.price,
                                        id: _p.id,
                                        isFavorite: _p.isFavorite,
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ));
  }
}
