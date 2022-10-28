import 'package:flutter/material.dart';

class CourseModel with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  CourseModel({
    required this.description,
    required this.imageUrl,
    required this.id,
    required this.title,
  });
}
