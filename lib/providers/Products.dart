import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/models/http_exception.dart';

import 'Product.dart';

class Products with ChangeNotifier {
  Products.auth(this.userId, this.token, this._items);
  Products();

  String? token;
  String? userId;

  List<Product>? _items = [];

  List<Product> get items {
    return _items!;
  }

  List<Product> get favoriteItems {
    return _items!.where((item) => item.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse('$serverUrl/products.json?auth=$token&$filterString');
    var favUrl = Uri.parse('$serverUrl/userFavorites/$userId.json?auth=$token');
    final favoriteResponse = await http.get(favUrl);
    final favoriteData = json.decode(favoriteResponse.body);

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[productId] ?? false,
            imageUrl: productData['imageUrl'],
          ),
        );
      });

      _items = loadedProducts;

      print('products loaded');
      notifyListeners();
    } catch (error) {
      print('This is error');
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String productId, Product newProduct) async {
    final productIndex =
        _items!.indexWhere((product) => product.id == productId);
    if (productIndex >= 0) {
      var url = Uri.parse('$serverUrl/products/$productId.json?auth=$token');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items![productIndex] = newProduct;
      notifyListeners();
      print('product update success');
    } else {
      print('update error...');
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse('$serverUrl/products.json?auth=$token');
    try {
      print(product);

      final res = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': userId,
          }));

      // TODO: DEBUG
      print('/// Add Product function');
      print(res.statusCode);

      Product p = Product(
        id: json.decode(res.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items!.add(p);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Product findById(String productId) {
    return _items!.firstWhere((product) => product.id == productId);
  }

  Future<void> deleteProductById(String id) async {
    var url = Uri.parse('$serverUrl/products/$id.json?auth=$token');
    final existingProductIndex =
        _items!.indexWhere((product) => product.id == id);

    Product? existingProduct = _items![existingProductIndex];

    _items!.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items!.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product.');
    }

    existingProduct = null;
  }
}
