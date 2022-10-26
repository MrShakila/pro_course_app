import 'cart_model.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> books;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.books,
      required this.dateTime});
}
