import 'package:flutter/material.dart';

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  final double price;
  bool isFav;

  Book({
    required this.description,
    required this.imageUrl,
    required this.id,
    required this.title,
    this.isFav = false,
    required this.price,
  });
  void toggleFavouriteStates() {
    isFav = !isFav;
    notifyListeners();
  }
}
