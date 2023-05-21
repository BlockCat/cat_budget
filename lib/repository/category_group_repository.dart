import '../models/category_group.dart';

abstract class CategoryGroupRepository {
  Future<List<CategoryGroup>> getAllCategoryGroups();
  Future<CategoryGroup?> getCategoryGroup(int id);
  Future<int> insert(CategoryGroup categoryGroup);
  Future<int> upsert(CategoryGroup categoryGroup);
  Future<int> update(int id, CategoryGroup categoryGroup);
  Future<int> deleteCategoryGroup(int id);
}
