import '../models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<List<Category>> getCategoriesByGroup(int groupId);
  Future<Category?> get(int id);
  Future<int> insert(Category category);
  Future<int> upsert(Category category);
  Future<int> update(int id, Category category);
  Future<int> delete(int id);
}
