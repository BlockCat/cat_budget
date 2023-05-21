import 'package:cat_budget/models/category.dart';
import 'package:cat_budget/repository/category_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteCategoryRepository extends CategoryRepository {
  final Database _database;

  SqliteCategoryRepository(this._database);

  @override
  Future<int> delete(int id) {
    return _database.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Category>> getAllCategories() {
    return _database.query('categories').then((value) =>
        value.map((e) => Category.fromMap(e)).toList(growable: false));
  }

  @override
  Future<List<Category>> getCategoriesByGroup(int groupId) {
    return _database
        .query('categories', where: 'group_id = ?', whereArgs: [groupId]).then(
            (value) =>
                value.map((e) => Category.fromMap(e)).toList(growable: false));
  }

  @override
  Future<Category?> get(int id) {
    return _database.query('categories', where: 'id = ?', whereArgs: [id]).then(
        (value) => value.map((e) => Category.fromMap(e)).firstOrNull);
  }

  @override
  Future<int> insert(Category category) {
    var map = category.toMap();
    map.remove('id');
    return _database.insert('categories', map);
  }

  @override
  Future<int> update(int id, Category category) {
    return _database.update('categories', category.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }
  
  @override
  Future<int> upsert(Category category) {
    if (category.id != null) {
      return update(category.id!, category);
    }
    return insert(category);
  }
}
