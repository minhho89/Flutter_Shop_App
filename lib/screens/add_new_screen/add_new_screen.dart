import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          title: const Text('Add new product'),
          actions: [
            IconButton(
              onPressed: _saveForm,
              icon: const Icon(Icons.save),
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
                        TextFormField(
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
                        TextFormField(
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
                        TextFormField(
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
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: _imageURLController.text.isEmpty
                                  ? const Text('Enter Image URL')
                                  : Image.network(_imageURLController.text,
                                      fit: BoxFit.fill),
                            ),
                            Expanded(
                              child: TextFormField(
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
                          ],
                        ),
                      ],
                    )),
              ));
  }
}
