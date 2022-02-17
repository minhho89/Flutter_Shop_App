import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  double get totalAmount {
    return price * quantity;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem>? _items = {};

  Map<String, CartItem>? get items {
    return {..._items!};
  }

  int get itemCount {
    return _items!.length;
  }

  int get quantityCount {
    int total = 0;
    _items!.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double calculateTotalAmount() {
    double total = 0.0;

    _items?.forEach((id, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void removeItem(String productId) {
    _items!.remove(productId);
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items!.containsKey(productId)) {
      _items!.update(
          productId,
          (existingCartItem) => CartItem(
                id: productId,
                title: title,
                price: price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items!.putIfAbsent(
        productId,
        () => CartItem(id: productId, title: title, price: price, quantity: 1),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
