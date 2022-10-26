import 'package:flutter/Material.dart';

import 'cart_model.dart';

class Cart with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.quantity * CartItem.price;
    });
    return total;
  }

  void addItem(String bookId, String title, double price) {
    if (_items.containsKey(bookId)) {
      //quantity +1
      _items.update(
          bookId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: price));
    } else {
      //add new entry
      _items.putIfAbsent(
          bookId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
