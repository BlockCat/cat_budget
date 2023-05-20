import 'package:flutter/widgets.dart';

@immutable
class Category {
  final int id;
  final String name;
  final double budget;
  final double total;

  const Category(
      {required this.id,
      required this.name,
      required this.budget,
      required this.total});
}
