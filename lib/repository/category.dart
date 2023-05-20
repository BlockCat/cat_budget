import 'package:cat_budget/models/category.dart';
import 'package:cat_budget/models/category_group.dart';

abstract class CategoryRepository {
  /// Returns a list of all category groups
  Future<List<CategoryGroup>> getGroups();

  /// Returns a list of all categories
  Future<List<Category>> getCategories();

  /// Deletes a category group
  Future<void> deleteGroup(int groupId);

  /// Deletes a list of categories
  Future<void> deleteCategories(Iterable<int> categoryIds);

  /// Creates a new category group
  Future<CategoryGroup> createGroup(CategoryGroup categoryGroup);

  Future<CategoryGroup> getGroup(int categoryId);
}
