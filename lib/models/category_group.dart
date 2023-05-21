import 'package:cat_budget/models/category.dart';

class CategoryGroup {
  final int? id;
  final String name;
  final int sort;

  final List<Category> categories;

  const CategoryGroup({
    this.id,
    required this.name,
    required this.sort,
    this.categories = const [],
  });

  @override
  String toString() {
    return 'CategoryGroup(id: $id, name: $name, sort: $sort)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sort': sort,
    };
  }

  static CategoryGroup fromMap(Map<String, dynamic> map) {
    return CategoryGroup(
      id: map['id'] as int?,
      name: map['name'] as String,
      sort: map['sort'] as int,
    );
  }
}
