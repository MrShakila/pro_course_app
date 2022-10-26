import 'package:flutter/Material.dart';

import 'cart_model.dart';
import 'order_item_model.dart';

class Orders with ChangeNotifier {
  // ignore: prefer_final_fields
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> books, double totalAmount) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: totalAmount,
            books: books,
            dateTime: DateTime.now()));

    notifyListeners();
  }
}
