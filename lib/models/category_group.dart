import 'package:flutter/widgets.dart';

import 'category.dart';

@immutable
class CategoryGroup {
  final int id;
  final String name;
  final List<Category> categories;

  const CategoryGroup({required this.id, required this.name, required this.categories});
}
