import 'package:cat_budget/models/category_group.dart';
import 'package:cat_budget/repository/category_group_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteCategoryGroupRepository extends CategoryGroupRepository {
  final Database _database;

  SqliteCategoryGroupRepository(this._database);

  @override
  Future<int> deleteCategoryGroup(int id) {
    return _database
        .delete('category_groups', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<CategoryGroup>> getAllCategoryGroups() {
    return _database.query('category_groups').then((value) =>
        value.map((e) => CategoryGroup.fromMap(e)).toList(growable: false));
  }

  @override
  Future<CategoryGroup?> getCategoryGroup(int id) {
    return _database.query('category_groups', where: 'id = ?', whereArgs: [
      id
    ]).then((value) => value.map((e) => CategoryGroup.fromMap(e)).firstOrNull);
  }

  @override
  Future<int> insert(CategoryGroup categoryGroup) {
    var map = categoryGroup.toMap();
    map.remove('id');
    return _database.insert('category_groups', map);
  }

  @override
  Future<int> upsert(CategoryGroup categoryGroup) {
    if (categoryGroup.id != null) {
      return update(categoryGroup.id!, categoryGroup);
    }
    return insert(categoryGroup);
  }

  @override
  Future<int> update(int id, CategoryGroup categoryGroup) {
    return _database.update('category_groups', categoryGroup.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }
}
